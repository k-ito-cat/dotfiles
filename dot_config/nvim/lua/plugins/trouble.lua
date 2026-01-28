-- diagnosticを一覧で見やすく表示するUI
return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({})
    end,
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>" },
      { "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>" },
    },
  },
}
