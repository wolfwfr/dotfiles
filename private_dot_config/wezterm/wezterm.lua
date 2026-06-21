-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Kanagawa (Gogh)"
config.font = wezterm.font("Deja Vu Sans Mono")
config.window_background_image = "/home/wolf/.config/wezterm/img/yellow-blue-blur.png"
config.window_background_opacity = 1.5
config.window_background_image_hsb = {
	-- Darken the background image by reducing it to 1/3rd
	brightness = 0.05,

	-- You can adjust the hue by scaling its value.
	-- a multiplier of 1.0 leaves the value unchanged.
	hue = 1.0,

	-- You can adjust the saturation also.
	saturation = 1.0,
}
config.font_size = 11
config.default_cwd = "/home/wolf/go/src/bitbucket.org/innius"
config.enable_tab_bar = false
-- config.default_prog = { "tmux" }

-- and finally, return the configuration to wezterm
return config
