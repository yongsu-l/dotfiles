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
    { 'echasnovski/mini.base16' },
    -- { "justinmk/vim-dirvish" },
    {
        'stevearc/oil.nvim',
        config = function ()
            require("oil").setup({
                -- default_file_explorer = false
            })
        end
    },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        {
            "tpope/vim-fugitive",
            config = function(_, _)
                -- deprecated function that still tab completes
                vim.api.nvim_del_user_command('Gbrowse')
            end
        },
        { "tpope/vim-rhubarb" },
        { "tpope/vim-unimpaired" },
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end
            },                                       -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            { 'lukas-reineke/lsp-format.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-buffer' },   -- Required
            { 'hrsh7th/cmp-path' },     -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        },
        config = function(_, _)
            vim.lsp.set_log_level("off")
            local cmp = require('cmp')

            cmp.setup({
                mapping = {
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                },
                sources = {
                    { name = 'path' },
                    { name = 'buffer' },
                    { name = 'nvim_lsp' },
                }
            })

            local lsp = require('lsp-zero').preset({
                configure_diagnostics = true,
            })

            lsp.on_attach(function(client, _)
                -- disable lsp syntax highlighting
                client.server_capabilities.semanticTokensProvider = nil
            end)

            lsp.configure('lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'silent', 'vim' }
                        }
                    }
                }
            })

            lsp.setup()
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                init = function()
                    -- PERF: no need to load the plugin, if we only need its queries for mini.ai
                    local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
                    local opts = require("lazy.core.plugin").values(plugin, "opts", false)
                    local enabled = false
                    if opts.textobjects then
                        for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
                            if opts.textobjects[mod] and opts.textobjects[mod].enable then
                                enabled = true
                                break
                            end
                        end
                    end
                    if not enabled then
                        require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
                    end
                end,
            },
        },
        opts = {
            highlight = {
                enable = true
            },
            indent = {
                enable = true
            },
            context_commentstring = {
                enable = true,
                enable_autocmd = false
            },
        },
        ---@param opts TSConfig
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    },
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        config = function(_, opts)
            require("fidget").setup(opts)
        end
    },
    {
        "echasnovski/mini.indentscope",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            symbol = "│",
            options = { try_as_border = true },
        },
    }
})

----------------------------------------
-- options
----------------------------------------

vim.cmd.colorscheme("base16-default-dark") -- colorscheme
vim.opt.number = true                      -- Print line number
-- vim.opt.relativenumber = true -- Relative line numbers
vim.opt.termguicolors = true               -- True color support
vim.opt.splitright = true                  -- Put new windows right of current
vim.opt.splitbelow = true                  -- Put new windows below of current
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true                  -- Ignore case

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.tabstop = 4

vim.opt.updatetime = 100

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

keymap.set("n", "gd", '<cmd>lua require("fzf-lua").lsp_definitions({ jump_to_single_result = true })<CR>')
keymap.set("n", "gD", '<cmd>lua require("fzf-lua").lsp_declarations({ jump_to_single_result = true })<CR>')
keymap.set("n", "gi", '<cmd>lua require("fzf-lua").lsp_implementations({ jump_to_single_result = true })<CR>')
keymap.set("n", "gr", '<cmd>lua require("fzf-lua").lsp_references({ ignore_current_line = true })<CR>')
keymap.set("n", "<leader>ca", '<cmd>lua require("fzf-lua").lsp_code_actions({ sync = true })<cr>')

keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

----------------------------------------
-- functions
----------------------------------------

vim.api.nvim_create_autocmd(
    'TermOpen',
    {
        pattern = '*',
        command = 'startinsert'
    }
)

vim.api.nvim_create_user_command('PR', 'terminal gh pr create', { nargs = 0 })

vim.api.nvim_create_user_command('GPush', 'Git --no-pager push', { nargs = 0})
vim.api.nvim_create_user_command('GPull', 'Git --no-pager pull', { nargs = 0})

-- To make GBrowse work with oil.nvim without netrw
vim.api.nvim_create_user_command(
  'Browse',
  function (opts)
    vim.fn.system { 'open', opts.fargs[1] }
  end,
  { nargs = 1 }
)

----------------------------------------
-- statuslines
----------------------------------------
local fn, cmd = vim.fn, vim.cmd

function my_statusline()
  local branch = fn.FugitiveHead()

  if branch and #branch > 0 then
    branch = '  '..branch
  end

  return ' %f%m%=%l:%c'..branch
end

cmd[[ set statusline=%!luaeval('my_statusline()') ]]
