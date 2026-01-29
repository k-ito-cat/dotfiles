local M = {}

function M.setup()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")

  dashboard.section.header.val = {
    "",
    "",
  }

  dashboard.section.buttons.val = {
    dashboard.button("e", "󰈔  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("f", "󰱼  Find file", ":Telescope find_files <CR>"),
    dashboard.button("g", "󰱼  Live grep", ":Telescope live_grep <CR>"),
    dashboard.button("r", "󰄉  Recent", ":Telescope oldfiles <CR>"),
    dashboard.button("c", "󰒓  Config", ":e $MYVIMRC <CR>"),
    dashboard.button("q", "󰩈  Quit", ":qa <CR>"),
  }

  local v = vim.version()
  dashboard.section.footer.val = string.format(
    "Neovim v%d.%d.%d  •  %s",
    v.major,
    v.minor,
    v.patch,
    os.date("%Y-%m-%d %H:%M")
  )

  dashboard.config.opts.noautocmd = true
  alpha.setup(dashboard.config)

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "alpha",
    callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn = "no"
      vim.opt_local.foldenable = false
    end,
  })
end

return M

