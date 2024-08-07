local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "RRethy/nvim-base16" },
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				view_opetions = {
					show_hidden = true,
				},
			})
		end,
	},
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function ()
            require ("fzf-lua").setup({ 'default-title', defaults = { formatter = 'path.filename_first' }})
        end
	},
	{
		{
			"tpope/vim-fugitive",
			config = function(_, _)
				-- deprecated function that still tab completes
				vim.api.nvim_del_user_command("Gbrowse")
			end,
		},
		{ "tpope/vim-rhubarb" },
		{ "tpope/vim-unimpaired" },
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
			{ "hrsh7th/cmp-buffer" }, -- Required
			{ "hrsh7th/cmp-path" }, -- Required
		},
		config = function()
			-- Here is where you configure the autocompletion settings.
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			-- And you can configure cmp even more, if you want to.
			local cmp = require("cmp")

			cmp.setup({
				formatting = lsp_zero.cmp_format(),
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				}),
				sources = {
					{ name = "path" },
					{ name = "buffer" },
					{ name = "nvim_lsp" },
				},
			})
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			vim.lsp.set_log_level("off")
			-- This is where all the LSP shenanigans will live
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			lsp_zero.format_on_save({
				format_opts = {
					async = true,
					timeout_ms = 10000,
				},
				servers = {
					["gopls"] = { "go" },
					["terraformls"] = { "terraform" },
				},
			})

			--- if you want to know more about lsp-zero and mason.nvim
			--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
			lsp_zero.on_attach(function(client, bufnr)
				-- disable lsp syntax highlighting
				client.server_capabilities.semanticTokensProvider = nil
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)

			require("mason-lspconfig").setup({
				ensure_installed = {"gopls", "tsserver", "terraformls", "lua_ls"},
				handlers = {
					lsp_zero.default_setup,
					lua_ls = function()
						-- (Optional) Configure lua language server for neovim
						local lua_opts = lsp_zero.nvim_lua_ls()
						require("lspconfig").lua_ls.setup(lua_opts)
					end,
                    gopls = function()
                        require("lspconfig").gopls.setup({
                            settings = {
                                gopls = {
                                    ["build.buildFlags"] = {"-mod=readonly"},
                                }
                            }
                        })
                    end,
				},
			})
        end,
	},
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        -- opts = {
        --     mode = "document_diagnostics",
        -- },
    },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			highlight = {
				enable = true,
			},
			indent = {
				enable = false,
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
            ensure_installed = { "go", "lua", "vim", "vimdoc", "typescript", "terraform", "ruby", "rust" }
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"j-hui/fidget.nvim",
		-- tag = "legacy",
		config = function(_, opts)
			require("fidget").setup(opts)
		end,
	},
	{
		"echasnovski/mini.indentscope",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.cmd("au TermOpen * lua vim.b.minicursorword_disable = true")
		end,
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
	},
    {
        "olexsmir/gopher.nvim",
        ft = "go",
        -- branch = "develop", -- if you want develop branch
        -- keep in mind, it might break everything
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
        },
        -- (optional) will update plugin's deps on every update
        build = function()
            vim.cmd.GoInstallDeps()
        end,
        ---@type gopher.Config
        opts = {},
    },
    {
        "ggandor/leap.nvim",
        enabled = true,
        keys = {
            { "s", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
            { "S", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
        },
        config = function(_, opts)
            local leap = require("leap")
            for k, v in pairs(opts) do
                leap.opts[k] = v
            end
            leap.add_default_mappings(true)
            vim.keymap.del({ "x", "o" }, "x")
            vim.keymap.del({ "x", "o" }, "X")
        end,
    },
    -- {
    --     "folke/flash.nvim",
    --     event = "VeryLazy",
    --     ---@type Flash.Config
    --     opts = {
    --         modes = {
    --             search = {
    --                 enabled = true
    --             }
    --         }
    --     },
    --     -- stylua: ignore
    --     keys = {
    --         { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    --         { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    --         { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    --         { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    --         { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    --     },
    -- }
})

----------------------------------------
-- options
----------------------------------------

vim.cmd.colorscheme("base16-default-dark") -- colorscheme
vim.opt.number = true -- Print line number
-- vim.opt.relativenumber = true -- Relative line numbers
vim.opt.termguicolors = true -- True color support
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitbelow = true -- Put new windows below of current
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true -- Ignore case

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
-- vim.opt.smarttab = false
vim.opt.tabstop = 4

vim.opt.updatetime = 100

-- Disable mouse
vim.opt.mouse = nil

-- Disable swap
vim.opt.swapfile = false

----------------------------------------
-- keymaps
----------------------------------------
local keymap = vim.keymap

vim.g.mapleader = ","
vim.g.maplocalleader = ","
keymap.set("n", "<leader><space>", ":noh<CR>", { desc = "Clear highlight" })
keymap.set("v", "p", "pgvy", { desc = "Paste in visual mode without copying" })

keymap.set("n", "<leader>f", "<cmd>FzfLua files<CR>")
keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<CR>")
keymap.set("n", "<leader>/", "<cmd>FzfLua live_grep_glob<CR>")
keymap.set("n", "<leader>,", "<cmd>FzfLua resume<CR>")

keymap.set("n", "<leader>v", "<cmd>FzfLua grep_cword<CR>")
keymap.set("v", "<leader>v", "<cmd>FzfLua grep_visual<CR>")

keymap.set("n", "gd", '<cmd>lua require("fzf-lua").lsp_definitions({ jump_to_single_result = true })<CR>')
keymap.set("n", "gD", '<cmd>lua require("fzf-lua").lsp_declarations({ jump_to_single_result = true })<CR>')
keymap.set("n", "gi", '<cmd>lua require("fzf-lua").lsp_implementations({ jump_to_single_result = true })<CR>')
keymap.set("n", "gr", '<cmd>lua require("fzf-lua").lsp_references({ ignore_current_line = true })<CR>')
keymap.set("n", "<leader>ca", '<cmd>lua require("fzf-lua").lsp_code_actions({ sync = true })<cr>')
keymap.set("n", "<C-k>", [[<Cmd>lua require"fzf-lua".builtin()<CR>]], {})
keymap.set("n", "gx", [[<Cmd>silent !open <cWORD><CR>]], {})

keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")
keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

----------------------------------------
-- LSP
----------------------------------------
vim.diagnostic.config({
    virtual_text = false -- turn off inline diagnostics
})

vim.api.nvim_create_augroup('diagnostics', { clear = true })

-- automatically populate loclisfunctionst
vim.api.nvim_create_autocmd('DiagnosticChanged', {
    group = 'diagnostics',
    callback = function()
        vim.diagnostic.setloclist({ open = false })
    end,
})

----------------------------------------
-- functions
----------------------------------------

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	command = "startinsert",
})

vim.api.nvim_create_user_command("PR", "terminal gh pr create", { nargs = 0 })

vim.api.nvim_create_user_command("GPush", "Git --no-pager push", { nargs = 0 })
vim.api.nvim_create_user_command("GPull", "Git --no-pager pull", { nargs = 0 })

-- To make GBrowse work with oil.nvim without netrw
vim.api.nvim_create_user_command("Browse", function(opts)
	vim.fn.system({ "open", opts.fargs[1] })
end, { nargs = 1 })

----------------------------------------
-- statuslines
----------------------------------------
local fn, cmd = vim.fn, vim.cmd

function my_statusline()
	local branch = fn.FugitiveHead()

	if branch and #branch > 0 then
		branch = "  " .. branch
	end

	return " %f%m%=%l:%c" .. branch
end

cmd([[ set statusline=%!luaeval('my_statusline()') ]])

-- Resize window when we resize the terminal / tmux
vim.api.nvim_command('autocmd VimResized * wincmd =')

vim.api.nvim_create_augroup('diagnostics', { clear = true })

vim.api.nvim_create_autocmd('DiagnosticChanged', {
    group = 'diagnostics',
    callback = function()
        vim.diagnostic.setloclist({ open = false })
    end,
})
