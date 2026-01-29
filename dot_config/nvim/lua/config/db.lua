local M = {}

function M.setup()
  vim.g.dbs = {
    ["local_pg"] = "postgres://postgres:postgres@localhost:5432/postgres",
    -- ["local_mysql"] = "mysql://root:root@127.0.0.1:3306/mysql",
    -- ["local_sqlite"] = "sqlite:/absolute/path/to/db.sqlite3",
  }

  vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
  vim.g.db_ui_show_database_icon = 1
  vim.g.db_ui_win_position = "left"
  vim.g.db_ui_winwidth = 40

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "mysql", "plsql" },
    callback = function()
      vim.bo.omnifunc = "vim_dadbod_completion#omni"
    end,
  })
end

return M

