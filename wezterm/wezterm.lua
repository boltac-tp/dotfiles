local wezterm = require("wezterm")
local start

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	start = { "wsl.exe", "~", "--distribution", "ArchLinux", "--exec", "/usr/bin/zsh", "-l" }
else
	start = { "/usr/bin/zsh", "-l" }
end

return {
	default_prog = start,
	font = wezterm.font_with_fallback({ "HackGenNerd Console", "HackGen Console NF" }),
	color_scheme = "tokyonight_moon",
}
