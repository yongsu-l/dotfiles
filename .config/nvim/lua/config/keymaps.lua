-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader><space>", ":noh<CR>", { desc = "Clear highlight" })

-- FZF and LSP from https://github.com/ibhagwan/fzf-lua
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep" })
vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<cr>", { desc = "References" })
vim.keymap.set("n", "ca", "<cmd>FzfLua lsp_code_actions<cr>", { desc = "Code actions" })
