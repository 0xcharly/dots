local wezterm = require("wezterm")
local colorscheme = require("colors.chroma")

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local edge_background = colorscheme.tab_bar.background
	local background = colorscheme.tab_bar.inactive_tab.bg_color
	local foreground = colorscheme.tab_bar.inactive_tab.fg_color

	if tab.is_active then
		background = colorscheme.tab_bar.active_tab.bg_color
		foreground = colorscheme.tab_bar.active_tab.fg_color
	elseif hover then
		background = colorscheme.tab_bar.inactive_tab_hover.bg_color
		foreground = colorscheme.tab_bar.inactive_tab_hover.fg_color
	end

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	local title = wezterm.truncate_right(tab.active_pane.title, max_width - 2)

	return {
		{
			Background = {
				Color = (tab.tab_index == 0 and background or edge_background),
			},
		},
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = " " .. title .. " " },
		{ Background = { Color = edge_background } },
	}
end)

return {
	-- Spawn a fish shell in login mode
	-- default_prog = { "/opt/homebrew/bin/fish", "-l" },
	-- term = 'wezterm',

	-- Use Pragmata Pro with ligature and Nerd icons as main font.
	-- Use Codicon for VSCode glyphs.
	-- Use variations of the Pragmata Pro font (with less features) as fallbacks.
	-- Use other fonts I like as fallback in case they are installed, but Pragmata
	-- is not.
	font = wezterm.font_with_fallback({ "Berkeley Mono", "Symbols Nerd Font", "Material Design Icons Desktop" }),
	-- Font size 14 for the best rendering.  Might be on the smaller side at some
	-- DPI/screen resolutions.
	font_size = 18,
	-- Enable the tab bar, use simple look.
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = false,
	use_fancy_tab_bar = false,
	-- No title bar, but allow resize.
	window_decorations = "RESIZE",
	-- Colorscheme load above and also used for the tab bar.
	colors = colorscheme,
	-- Some common hyperlink rules.
	hyperlink_rules = {
		{ regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b", format = "$0" },
		{ regex = "\\b\\w+://(?:[\\w.-]+)\\S*\\b", format = "$0" },
		{ regex = "\\bfile://\\S*\\b", format = "$0" },
		{ regex = "\\bb/(\\d+)\\b", format = "https://b.corp.google.com/issues/$1" },
		{
			regex = "\\bcl/(\\d+)\\b",
			format = "https://critique.corp.google.com/issues/$1",
		},
	},
}
