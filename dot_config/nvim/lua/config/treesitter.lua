local M = {}

function M.setup()
  local languages = {
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
  }

  local ok_ts, ts = pcall(require, "nvim-treesitter")
  if not ok_ts then
    vim.notify("nvim-treesitter が見つかりません", vim.log.levels.WARN)
    return
  end

  ts.setup()
  ts.install(languages)

  local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = {
      "html",
      "css",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "json",
      "lua",
      "markdown",
    },
    callback = function(args)
      local ok_start = pcall(vim.treesitter.start, args.buf)
      if not ok_start then
        return
      end
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

return M
