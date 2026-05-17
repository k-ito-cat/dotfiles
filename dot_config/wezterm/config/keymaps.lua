local M = {}

function M.apply(config, wezterm, mux, workspaces)
  local act = wezterm.action

  config.keys = {
    { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
    { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },

    { key = "t", mods = "CTRL|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },

    {
      key = "n",
      mods = "CTRL|SHIFT",
      action = wezterm.action_callback(function(window, pane)
        workspaces.show_picker(window, pane, wezterm, mux, act)
      end),
    },

    {
      key = "d",
      mods = "CTRL|SHIFT",
      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    { key = "e", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

    { key = "[", mods = "CTRL|SHIFT", action = act.RotatePanes("CounterClockwise") },
    { key = "]", mods = "CTRL|SHIFT", action = act.RotatePanes("Clockwise") },
    { key = "phys:LeftBracket", mods = "CTRL|SHIFT", action = act.RotatePanes("CounterClockwise") },
    { key = "phys:RightBracket", mods = "CTRL|SHIFT", action = act.RotatePanes("Clockwise") },
    -- 分割ビュー閉じる
    {
      key = "w",
      mods = "CTRL",
      action = wezterm.action_callback(function(window, pane)
        local tab = window:active_tab()
        local panes = tab:panes_with_info()

        if #panes > 1 then
          window:perform_action(act.CloseCurrentPane({ confirm = false }), pane)
        end
      end),
    },
    -- 分割タブ閉じる
    { key = "w", mods = "CTRL|SHIFT", action = act.CloseCurrentTab({ confirm = false }) },

    { key = "r", mods = "CTRL|SHIFT", action = act.ReloadConfiguration },
  }
end

return M
