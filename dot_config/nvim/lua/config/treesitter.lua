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

  local ok_configs, configs = pcall(require, "nvim-treesitter.configs")
  if ok_configs then
    configs.setup({
      ensure_installed = languages,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
    })
    return
  end

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
    callback = function()
      vim.treesitter.start()
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

return M
