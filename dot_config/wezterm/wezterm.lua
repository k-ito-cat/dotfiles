local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}

local target = wezterm.target_triple
local is_darwin = target:find("apple") ~= nil
local is_windows = target:find("windows") ~= nil

if is_windows then
  config.default_domain = 'WSL:Ubuntu'
end

-- ベル音を消す
config.audible_bell = "Disabled"

-- 代わりに弱い光で知らせる
config.visual_bell = {
  fade_in_duration_ms = 30,
  fade_out_duration_ms = 30,
}

-- ビジュアルベルの色
config.colors = config.colors or {}
config.colors.visual_bell = "#0b0f14"

if is_windows then
  local wsl_domains = wezterm.default_wsl_domains()
  for _, dom in ipairs(wsl_domains) do
    if dom.name == 'WSL:Ubuntu' then
      dom.default_prog = { 'zsh', '-l' }
      dom.default_cwd = '~'
    end
  end
  config.wsl_domains = wsl_domains
end

config.window_decorations = "RESIZE"

config.font = wezterm.font_with_fallback {
  'JetBrains Mono',
  'Symbols Nerd Font Mono',
  'Noto Sans Mono CJK JP',
}
config.font_size = 12.5
config.line_height = 1.08
config.default_cursor_style = "SteadyBar"
config.window_padding = { left = 10, right = 10, top = 8, bottom = 8 }

config.color_scheme = 'Tokyo Night'
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = 'NeverPrompt'

-- 透明
if is_windows then
  config.win32_system_backdrop = 'Disable'
end
config.window_background_opacity = 0.76
config.text_background_opacity = 0.86

config.keys = {
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },

  { key = 't', mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' },

  { key = 'd', mods = 'CTRL|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'e', mods = 'CTRL|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

  { key = 'h', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Down' },
-- 分割ビュー閉じる
 {
  key = 'w',
  mods = 'CTRL',
  action = wezterm.action_callback(function(window, pane)
    local tab = window:active_tab()
    local panes = tab:panes_with_info()

    if #panes > 1 then
      window:perform_action(act.CloseCurrentPane { confirm = false }, pane)
    end
  end),
},
-- 分割タブ閉じる
{ key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = false } },


  { key = 'r', mods = 'CTRL|SHIFT', action = act.ReloadConfiguration },
}

return config

