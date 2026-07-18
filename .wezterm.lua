-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
config.font = wezterm.font("JetBrains Mono", { weight = "DemiBold" })
config.color_scheme = 'rose-pine'
config.enable_tab_bar = false
config.window_background_opacity = 0.85
config.text_background_opacity = 1.0
config.enable_kitty_graphics = true
config.kde_window_background_blur = true
config.initial_cols = 173
config.initial_rows = 40
config.window_padding = {
  left = '0cell',
  right = '0cell',
  top = '0cell',
  bottom = '0cell',
}

return config
