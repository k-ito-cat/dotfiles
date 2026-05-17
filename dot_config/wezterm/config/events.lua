local M = {}

local function basename(path)
  if not path or path == "" then
    return nil
  end

  local normalized = path:gsub("[\\/]$", "")
  return normalized:match("([^/\\]+)$") or normalized
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

function M.setup(wezterm)
  wezterm.on("format-tab-title", function(tab, tabs, panes, pane_config, hover, max_width)
    local title = wezterm.truncate_right(tab_title(tab), math.max(max_width - 2, 0))
    return { { Text = " " .. title .. " " } }
  end)

  -- 起動時にフルスクリーン化（Alt+Enter相当の状態で開く）
  wezterm.on("gui-startup", function(cmd)
    local _, _, window = wezterm.mux.spawn_window(cmd or {})
    window:gui_window():toggle_fullscreen()
  end)
end

return M
