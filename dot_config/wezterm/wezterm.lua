local wezterm = require("wezterm")
local mux = wezterm.mux

local config = wezterm.config_builder()
local target = wezterm.target_triple
local context = {
  is_darwin = target:find("apple") ~= nil,
  is_windows = target:find("windows") ~= nil,
}

local function load_config_module(name)
  return dofile(wezterm.config_dir .. "/config/" .. name .. ".lua")
end

load_config_module("core").apply(config, wezterm, context)
load_config_module("ui").apply(config, wezterm, context)

local workspaces = load_config_module("workspaces")
load_config_module("keymaps").apply(config, wezterm, mux, workspaces)
load_config_module("events").setup(wezterm)

return config
