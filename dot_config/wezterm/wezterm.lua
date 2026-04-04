local wezterm = require 'wezterm'
local act = wezterm.action
-- 0x96f theme by Filip Janevski: https://0x96f.dev/
local theme = dofile(wezterm.config_dir .. '/colors/0x96f.lua')

local config = {}

local target = wezterm.target_triple
local is_darwin = target:find("apple") ~= nil
local is_windows = target:find("windows") ~= nil

local function basename(path)
  if not path or path == '' then
    return nil
  end

  local normalized = path:gsub('[\\/]$', '')
  return normalized:match('([^/\\]+)$') or normalized
end

local function tab_title(tab_info)
  local explicit_title = tab_info.tab_title
  if explicit_title and #explicit_title > 0 then
    return explicit_title
  end

  local pane = tab_info.active_pane
  local cwd = pane.current_working_dir

  if cwd then
    local dir = cwd.file_path or tostring(cwd)
    local title = basename(dir)
    if title and #title > 0 then
      return title
    end
  end

  local process_name = basename(pane.foreground_process_name)
  if process_name and #process_name > 0 then
    return process_name
  end

  return pane.title
end

if is_windows then
  config.default_domain = 'WSL:Ubuntu'
  config.allow_win32_input_mode = true
  config.ime_preedit_rendering = 'System'
  config.enable_kitty_keyboard = false
end

-- ベル音を消す
config.audible_bell = "Disabled"

-- 代わりに弱い光で知らせる
config.visual_bell = {
  fade_in_duration_ms = 30,
  fade_out_duration_ms = 30,
}

-- ビジュアルベルの色
config.colors = theme
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

if is_windows then
  config.font = wezterm.font_with_fallback {
    'JetBrains Mono',
    'Symbols Nerd Font Mono',
    'Noto Sans Mono CJK JP',
  }
  config.font_size = 10
  config.line_height = 1.08
elseif is_darwin then
  config.font = wezterm.font_with_fallback {
    'Menlo',
    'Hiragino Sans',
    'Symbols Nerd Font Mono',
    'Apple Color Emoji',
  }
  config.font_size = 14
  config.line_height = 1.05
else
  config.font = wezterm.font_with_fallback {
    'JetBrains Mono',
    'Noto Sans Mono CJK JP',
    'Symbols Nerd Font Mono',
  }
  config.font_size = 10
  config.line_height = 1.08
end
config.default_cursor_style = "SteadyBar"
config.window_padding = { left = 10, right = 10, top = 8, bottom = 8 }
config.use_fancy_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.tab_bar_style = {
  new_tab = wezterm.format {
    { Text = ' + ' },
  },
  new_tab_hover = wezterm.format {
    { Text = ' + ' },
  },
}

config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = 'NeverPrompt'

-- 透明
if is_windows then
  config.win32_system_backdrop = 'Disable'
end
config.window_background_opacity = 1.0
config.text_background_opacity = 1.0

config.keys = {
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },

  { key = 't', mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' },

  { key = 'd', mods = 'CTRL|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'e', mods = 'CTRL|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

  { key = '[', mods = 'CTRL|SHIFT', action = act.RotatePanes 'CounterClockwise' },
  { key = ']', mods = 'CTRL|SHIFT', action = act.RotatePanes 'Clockwise' },
  { key = 'phys:LeftBracket', mods = 'CTRL|SHIFT', action = act.RotatePanes 'CounterClockwise' },
  { key = 'phys:RightBracket', mods = 'CTRL|SHIFT', action = act.RotatePanes 'Clockwise' },
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

wezterm.on('format-tab-title', function(tab, tabs, panes, pane_config, hover, max_width)
  local title = wezterm.truncate_right(tab_title(tab), math.max(max_width - 2, 0))
  return { { Text = ' ' .. title .. ' ' } }
end)

return config
