return {
  "SidOfc/carbon.nvim",
  enabled = false,
  keys = {
    {
      "<C-n>",
      "<cmd>ToggleSidebarCarbon!<cr>",
      desc = "Open file explorer",
    },
  },
  lazy = false,
  init = function()
    vim.g.carbon_lazy_init = true
  end,
  opts = {
    sidebar_width = 45,
  },
}
