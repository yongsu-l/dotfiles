return {
  {
    "ibhagwan/fzf-lua",
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
        "<cmd>FzfLua live_grep<cr>",
        desc = "Livegrep",
      },
    },
  },
}
