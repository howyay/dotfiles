-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'
config.font = wezterm.font 'Sarasa Mono SC Nerd Font'
config.hide_tab_bar_if_only_one_tab = true
config.enable_wayland = true
config.hide_mouse_cursor_when_typing = false

-- and finally, return the configuration to wezterm
return config

