local config = wezterm.config_builder()

local DARK_COLOR_SCHEME = "deep"
local LIGHT_COLOR_SCHEME = "One Light (base16)"

local THEME_PATH = os.getenv("HOME") .. "/.local/state/theme"

local function read_theme()
	local content = "dark"
	local theme_file, err = io.open(THEME_PATH, "r")
	if theme_file then
		content = theme_file:read("*a")
		theme_file:close()
	else
		print(err)
	end
	return content
end

local function write_theme(theme_text)
	local theme_file, err = io.open(THEME_PATH, "w")
	if theme_file then
		theme_file:write(theme_text)
		theme_file:close()
	else
		print(err)
	end
end

wezterm.on("toggle-colorscheme", function(window, pane)
	local overrides = window:get_config_overrides() or {}

	-- Overwrite theme file.
	local current_theme = read_theme()
	if current_theme == "dark" then
		write_theme("light")
	else
		write_theme("dark")
	end

	-- Set current theme based on theme file.
	current_theme = read_theme()
	if current_theme == "light" then
		overrides.color_scheme = LIGHT_COLOR_SCHEME
	else
		overrides.color_scheme = DARK_COLOR_SCHEME
	end

	window:set_config_overrides(overrides)
end)

config.keys = {
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
	-- Switch color scheme
	{ key = "t", mods = "OPT", action = wezterm.action.EmitEvent("toggle-colorscheme") },
}

return config
