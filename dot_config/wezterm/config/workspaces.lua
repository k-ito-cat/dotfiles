local M = {}

-- editor workspace に入る（無ければ作る）
local function enter_editor_workspace(mux)
  for _, name in ipairs(mux.get_workspace_names()) do
    if name == "editor" then
      mux.set_active_workspace("editor")
      return
    end
  end
  mux.spawn_window({ workspace = "editor", cwd = "~" })
  mux.set_active_workspace("editor")
end

-- dotfiles workspace に入る（無ければ作る）
local function enter_dotfiles_workspace(wezterm, mux)
  for _, name in ipairs(mux.get_workspace_names()) do
    if name == "dotfiles" then
      mux.set_active_workspace("dotfiles")
      return
    end
  end
  mux.spawn_window({
    workspace = "dotfiles",
    cwd = wezterm.home_dir .. "/.local/share/chezmoi",
  })
  mux.set_active_workspace("dotfiles")
end

-- workspace 一覧から切替（未作成のものは作成オプションを末尾に追加）
function M.show_picker(window, pane, wezterm, mux, act)
  local choices = {}
  local has_editor = false
  local has_dotfiles = false
  for _, name in ipairs(mux.get_workspace_names()) do
    if name == "editor" then
      has_editor = true
    end
    if name == "dotfiles" then
      has_dotfiles = true
    end
    table.insert(choices, { label = name, id = name })
  end
  if not has_editor then
    table.insert(choices, { label = "+ editor", id = "__new_editor" })
  end
  if not has_dotfiles then
    table.insert(choices, { label = "+ dotfiles", id = "__new_dotfiles" })
  end
  window:perform_action(
    act.InputSelector({
      title = "Workspaces",
      fuzzy = true,
      choices = choices,
      action = wezterm.action_callback(function(_, _, id, _)
        if not id then
          return
        end
        if id == "__new_editor" then
          enter_editor_workspace(mux)
        elseif id == "__new_dotfiles" then
          enter_dotfiles_workspace(wezterm, mux)
        else
          mux.set_active_workspace(id)
        end
      end),
    }),
    pane
  )
end

return M
