-- Import the wezterm module
local wezterm = require 'wezterm'
-- Creates a config object which we will be adding our config to
local config = wezterm.config_builder()

-- (This is where our config will go)
config.color_scheme = 'Catppuccin Mocha'
config.font_size = 12

-- Slightly transparent and blurred background
config.window_background_opacity = 0.85
config.macos_window_background_blur = 30
-- Removes the title bar, leaving only the tab bar. Keeps
-- the ability to resize by dragging the window's edges.
-- On macOS, 'RESIZE|INTEGRATED_BUTTONS' also looks nice if
-- you want to keep the window controls visible and integrate
-- them into the tab bar.
config.window_decorations = 'RESIZE|INTEGRATED_BUTTONS'

config.window_frame = {
  -- Berkeley Mono for me again, though an idea could be to try a
  -- serif font here instead of monospace for a nicer look?
  font = wezterm.font({ family = 'JetBrains Mono', weight = 'Bold' }),
  font_size = 11,
}

config.enable_scroll_bar = true
config.alternate_buffer_wheel_scroll_speed = 1
-- Returns our config to be evaluated. We must always do this at the bottom of this file
return config

