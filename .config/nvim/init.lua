vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.keymap.set("n", "<leader><space>", ":noh<CR>", { desc = "Clear highlight" })
vim.keymap.set("v", "p", "pgvy", { desc = "Paste in visual mode without copying"})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

vim.opt.updatetime = 100

vim.opt.number = true -- Print line number
-- vim.opt.relativenumber = true -- Relative line numbers
vim.opt.termguicolors = true -- True color support
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitbelow = true -- Put new windows below of current
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true -- Ignore case
vim.opt.inccommand = "nosplit" -- preview incremental substitute
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.termguicolors = true -- True color support

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.tabstop = 4

require("lazy").setup("plugins")

vim.cmd.colorscheme("base16-default-dark") -- colorscheme

vim.api.nvim_create_autocmd(
    'TermOpen',
    {
        pattern='*',
        command='startinsert'
    }
)

vim.api.nvim_create_user_command('PR', 'terminal gh pr create', { nargs = 0 })
