return {
  {
    "tpope/vim-dadbod",
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    config = function()
      require("config.db").setup()
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = {
      "tpope/vim-dadbod",
    },
    ft = { "sql", "mysql", "plsql" },
  },
}

