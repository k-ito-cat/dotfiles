local M = {}

function M.setup()
  local ok_configs, configs = pcall(require, "nvim-treesitter.configs")
  if not ok_configs then
    vim.notify("nvim-treesitter が見つかりません", vim.log.levels.WARN)
    return
  end

  local parser_install_dir = vim.fn.stdpath("data") .. "/site"
  vim.opt.runtimepath:prepend(parser_install_dir)

  configs.setup({
    parser_install_dir = parser_install_dir,
    ensure_installed = {
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
    },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  })
end

return M
