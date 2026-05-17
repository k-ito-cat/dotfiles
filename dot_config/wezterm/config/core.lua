local M = {}

function M.apply(config, wezterm, context)
  if context.is_windows then
    config.default_domain = "WSL:Ubuntu"
    config.use_ime = true
    config.ime_preedit_rendering = "System"
    config.enable_kitty_keyboard = false

    local wsl_domains = wezterm.default_wsl_domains()
    for _, dom in ipairs(wsl_domains) do
      if dom.name == "WSL:Ubuntu" then
        dom.default_prog = { "zsh", "-l" }
        dom.default_cwd = "~"
      end
    end
    config.wsl_domains = wsl_domains
  end

  -- ベル音を消す
  config.audible_bell = "Disabled"

  -- 代わりに弱い光で知らせる
  config.visual_bell = {
    fade_in_duration_ms = 30,
    fade_out_duration_ms = 30,
  }
  config.default_cursor_style = "SteadyBar"
  config.window_close_confirmation = "NeverPrompt"

  config.scrollback_lines = 10000
end

return M
