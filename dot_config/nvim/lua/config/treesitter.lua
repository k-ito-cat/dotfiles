local M = {}

function M.setup()
  local ok_treesitter, treesitter = pcall(require, "nvim-treesitter")
  if not ok_treesitter then
    vim.notify("nvim-treesitter が見つかりません", vim.log.levels.WARN)
    return
  end

  local parser_install_dir = vim.fn.stdpath("data") .. "/site"
  local parsers = {
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "svelte",
  }
  local filetypes = {
    "html",
    "css",
    "javascript",
    "typescript",
    "typescriptreact",
    "json",
    "lua",
    "markdown",
    "svelte",
  }

  treesitter.setup({
    install_dir = parser_install_dir,
  })

  treesitter.install(parsers)

  vim.api.nvim_create_autocmd("FileType", {
    pattern = filetypes,
    callback = function()
      pcall(vim.treesitter.start)
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

return M
