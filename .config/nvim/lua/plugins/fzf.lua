return {
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
	config = function()
		require("fzf-lua").setup({
			grep = {
					rg_glob = true
			}
		})
	end,
    keys = {
      {
        "<leader>f",
        "<cmd>FzfLua files<cr>",
        desc = "Fuzzy find files",
      },
      {
        "<leader>b",
        "<cmd>FzfLua buffers<cr>",
        desc = "Fuzzy find buffers",
      },
      {
        "<leader>/",
        "<cmd>FzfLua live_grep_glob<cr>",
        desc = "Livegrep with glob",
      },
      {
        "gd",
        '<cmd>lua require("fzf-lua").lsp_definitions({ jump_to_single_result = true })<cr>'
      },
      {
        "gD",
        '<cmd>lua require("fzf-lua").lsp_declarations({ jump_to_single_result = true })<cr>'
      },
      {
        "gi",
        '<cmd>lua require("fzf-lua").lsp_implementations({ jump_to_single_result = true })<cr>'
      },
      {
        "gr",
        '<cmd>lua require("fzf-lua").lsp_references({ jump_to_single_result = true, ignore_current_line = true })<cr>'
      },
      {
        "gca",
        '<cmd>lua require("fzf-lua").lsp_code_actions({ sync = true })<cr>'
      },
    },
  },
}
