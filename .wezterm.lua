-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
config.font = wezterm.font "JetBrains Mono Bold"
config.color_scheme = "carbonfox"
config.enable_tab_bar = false
config.window_background_opacity = 0.85
config.text_background_opacity = 1.0

return config
