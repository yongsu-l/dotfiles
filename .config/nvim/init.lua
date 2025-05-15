----------------------------------------
-- options
----------------------------------------

vim.opt.number = true -- Print line number
vim.opt.termguicolors = true -- True color support
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitbelow = true -- Put new windows below of current
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true -- Ignore case

vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
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

keymap.set("n", "gd", '<cmd>lua require("fzf-lua").lsp_definitions({ jump1 = true })<CR>')
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
	virtual_text = false, -- turn off inline diagnostics
})

vim.api.nvim_create_augroup("diagnostics", { clear = true })

-- automatically populate loclisfunctionst
vim.api.nvim_create_autocmd("DiagnosticChanged", {
	group = "diagnostics",
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
vim.api.nvim_create_user_command("Glog", "Git log -500", { nargs = 0 })

-- To make GBrowse work with oil.nvim without netrw
vim.api.nvim_create_user_command("Browse", function(opts)
	vim.fn.system({ "open", opts.fargs[1] })
end, { nargs = 1 })

----------------------------------------
-- statuslines
----------------------------------------
local fn = vim.fn

function my_statusline()
	local branch = fn.FugitiveHead()

	if branch and #branch > 0 then
		branch = "  " .. branch
	end

	return " %f%m%=%l:%c" .. branch
end

vim.opt.statusline = "%!v:lua.my_statusline()"

-- Resize window when we resize the terminal / tmux
vim.api.nvim_command("autocmd VimResized * wincmd =")

vim.api.nvim_create_augroup("diagnostics", { clear = true })

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	group = "diagnostics",
	callback = function()
		vim.diagnostic.setloclist({ open = false })
	end,
})
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
	{
		"RRethy/nvim-base16",
		config = function()
			vim.cmd.colorscheme("base16-default-dark") -- colorscheme
		end,
	},
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
		config = function()
			require("fzf-lua").setup({
				"default",
				defaults = { formatter = "path.filename_first", git_icons = false },
				git = {
					branches = {
						cmd = "git branch --color",
					},
				},
				keymap = {
					fzf = {
						["ctrl-q"] = "select-all+accept",
					},
				},
			})

			vim.api.nvim_create_user_command("Gswitch", "FzfLua git_branches", { nargs = 0 })
		end,
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
		{ "tpope/vim-sleuth" },
		{ "vim-ruby/vim-ruby" },
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v4.x",
		lazy = true,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
	},

	-- Autocompletion
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = "rafamadriz/friendly-snippets",
		version = "1.*",
		opts = {
			keymap = { preset = "enter" },
		},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function(_, opts)
			vim.lsp.set_log_level("off")
			-- This is where all the LSP shenanigans will live
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						["build.buildFlags"] = { "-mod=readonly" },
					},
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = { "terraformls", "gopls", "ts_ls", "ruby_lsp" },
			})

			local lspconfig = require("lspconfig")
			local blink = require("blink.cmp")
			local defaults = lspconfig.util.default_config
			defaults.capabilities = vim.tbl_deep_extend("force", defaults.capabilities, blink.get_lsp_capabilities())

			-- disable lsp highlighting and use treesitter
			for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
				vim.api.nvim_set_hl(0, group, {})
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		-- commit = "7e3942ceca9e0c28760f77ac33bc16399146d879",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			highlight = {
				enable = true,
			},
			indent = {
				-- enable = false,
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			ensure_installed = { "go", "lua", "vim", "vimdoc", "typescript", "ruby", "rust" },
			-- ensure_installed = { "go", "lua", "vim", "vimdoc", "typescript", "terraform", "ruby", "rust" },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					ruby = { "prettier" },
				},
				format_after_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			})
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
		config = function(_, opts)
			require("fidget").setup(opts)
		end,
	},
	{
		"echasnovski/mini.indentscope",
		version = "*",
	},
})
