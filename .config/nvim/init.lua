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
keymap.set("n", "<leader>/", "<cmd>FzfLua live_grep<CR>")
keymap.set("n", "<leader>,", "<cmd>FzfLua resume<CR>")

keymap.set("n", "<leader>v", "<cmd>FzfLua grep_cword<CR>")
keymap.set("v", "<leader>v", "<cmd>FzfLua grep_visual<CR>")

keymap.set("n", "gd", '<cmd>lua require("fzf-lua").lsp_definitions({ jump1 = true })<CR>')
keymap.set("n", "gD", '<cmd>lua require("fzf-lua").lsp_declarations({ jump_to_single_result = true })<CR>')
keymap.set("n", "gi", '<cmd>lua require("fzf-lua").lsp_implementations({ jump1 = true })<CR>')
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
-- set lower priority for semantic_tokens in case treesitter is available
vim.highlight.priorities.semantic_tokens = 95

vim.diagnostic.config({ virtual_text = true })

-- automatically populate loclisfunctionst
vim.api.nvim_create_augroup("diagnostics", { clear = true })
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
				-- "hide",
				-- "default",
				-- defaults = { formatter = "path.filename_first", git_icons = false },
				git = {
					branches = {
						cmd = "git branch --color",
					},
				},
				-- send grep'd things to quickfix list
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

				-- override cc in fugitive windows to use --no-verify
				vim.api.nvim_create_autocmd("FileType", {
					pattern = "fugitive",
					callback = function()
						vim.keymap.set("n", "cc", ":Git commit --no-verify<CR>", { buffer = true })
						vim.keymap.set("n", "ce", ":Git commit --amend --no-edit --no-verify<CR>", { buffer = true })
					end,
				})
			end,
		},
		{ "tpope/vim-rhubarb" },
		{ "tpope/vim-unimpaired" },
		{ "tpope/vim-sleuth" },
		{ "vim-ruby/vim-ruby" },
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
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function(_, opts)
			vim.lsp.config("gopls", {
				cmd = { "gopls", "-remote=auto" },
				settings = {
					gopls = {
						["build.buildFlags"] = { "-mod=readonly" },
					},
				},
			})
			vim.lsp.config("ruby_lsp", {
				settings = {
					["rubyLsp.bundleGemfile"] = "./Gemfile",
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = { "gopls", "ruby_lsp", "tsgo" },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		lazy = false,
		build = ":TSUpdate",
		-- opts = {
		-- 	highlight = {
		-- 		enable = true,
		-- 	},
		-- 	indent = {
		-- 		enable = true,
		-- 	},
		-- 	context_commentstring = {
		-- 		enable = true,
		-- 	},
		-- 	ensure_installed = { "go", "lua", "vim", "vimdoc", "typescript", "ruby", "rust" },
		-- },
		-- config = function(_, opts)
		-- 	require("nvim-treesitter.configs").setup(opts)
		-- end,
	},
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettier", "eslint" },
					typescript = { "prettier", "eslint" },
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
		-- automated bullet list for markdown. intentionally not using vim-markdown since we don't need all the features
		"bullets-vim/bullets.vim",
	},
})
