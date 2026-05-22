local M = {}

function M.apply(config, wezterm, context)
  -- 0x96f theme by Filip Janevski: https://0x96f.dev/
  local theme = dofile(wezterm.config_dir .. "/colors/0x96f.lua")

  -- ビジュアルベルの色
  config.colors = theme
  config.colors.visual_bell = "#0b0f14"
  config.window_decorations = "RESIZE"

  if context.is_windows then
    config.font = wezterm.font_with_fallback({
      "JetBrains Mono",
      "Symbols Nerd Font Mono",
      "Noto Sans Mono CJK JP",
    })
    config.font_size = 10
    config.line_height = 1.08
  elseif context.is_darwin then
    config.font = wezterm.font_with_fallback({
      "Menlo",
      "Hiragino Sans",
      "Symbols Nerd Font Mono",
      "Apple Color Emoji",
    })
    config.font_size = 13
    config.line_height = 1.08
  else
    config.font = wezterm.font_with_fallback({
      "JetBrains Mono",
      "Noto Sans Mono CJK JP",
      "Symbols Nerd Font Mono",
    })
    config.font_size = 10
    config.line_height = 1.08
  end

  config.window_padding = { left = 10, right = 10, top = 8, bottom = 8 }
  config.use_fancy_tab_bar = false
  config.show_tab_index_in_tab_bar = false
  config.tab_bar_style = {
    new_tab = wezterm.format({
      { Text = " + " },
    }),
    new_tab_hover = wezterm.format({
      { Text = " + " },
    }),
  }

  config.hide_tab_bar_if_only_one_tab = true

  -- 透明
  if context.is_darwin then
    config.macos_window_background_blur = 20
    config.colors.compose_cursor = "#ffca58"
    config.colors.cursor_bg = "#ffca58"
    config.colors.cursor_fg = "#262427"
    config.colors.cursor_border = "#ffca58"
    config.colors.selection_fg = "#262427"
    config.colors.selection_bg = "#ffd271"
  end
  config.window_background_opacity = context.is_darwin and 0.72
  config.text_background_opacity = context.is_darwin and 1.0 or 0.9
end

return M
