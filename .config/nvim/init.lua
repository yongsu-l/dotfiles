vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.keymap.set("n", "<leader><space>", ":noh<CR>", { desc = "Clear highlight" })

-- bootstrap lazy.nvim, LazyVim and your plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup("plugins")

vim.o.conceallevel = 0

local opt = vim.opt

opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.termguicolors = true -- True color support
opt.splitright = true -- Put new windows right of current
opt.splitbelow = true -- Put new windows below of current
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.smartcase = true -- Don't ignore case with capitals
opt.termguicolors = true -- True color support

opt.wildmenu = true

opt.smartindent = true -- Insert indents automatically
opt.shiftround = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4

vim.cmd.colorscheme("base16-default-dark") -- colorscheme

local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()
