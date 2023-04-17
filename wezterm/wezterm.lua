local wezterm = require("wezterm")
local start

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	start = { "wsl.exe", "~", "--distribution", "Ubuntu-22.04", "--exec", "/usr/bin/zsh", "-l" }
else
	start = { "/usr/bin/zsh", "-l" }
end

return {
	default_prog = start,
	font = wezterm.font("HackGenNerd Console"),
	color_scheme = "tokyonight_moon",
}
