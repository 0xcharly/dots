local wezterm = require 'wezterm'
local mrsuit = require 'mrsuit'

function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab.tab_title
    -- if the tab title is explicitly set, take that.
    if title and #title > 0 then
      return title
    end
    -- Otherwise, use the title from the active pane in that tab.
    return tab.active_pane.title
  end
)

local config = {
  -- Spawn a fish shell in login mode
  -- default_prog = { "/opt/homebrew/bin/fish", "-l" },
  -- term = 'wezterm',

  -- https://wezfurlong.org/wezterm/config/lua/config/font.html
  font = wezterm.font_with_fallback { 'Berkeley Mono', 'Symbols Nerd Font', 'Material Design Icons Desktop' },
  -- https://wezfurlong.org/wezterm/config/lua/config/font_size.html
  -- Font size 14 for the best rendering.  Might be on the smaller side at some
  -- DPI/screen resolutions.
  font_size = 14,
  -- https://wezfurlong.org/wezterm/config/lua/config/enable_tab_bar.html
  enable_tab_bar = true,
  -- https://wezfurlong.org/wezterm/config/lua/config/use_fancy_tab_bar.html
  use_fancy_tab_bar = true,
  -- https://wezfurlong.org/wezterm/config/lua/config/hide_tab_bar_if_only_one_tab.html
  hide_tab_bar_if_only_one_tab = false,
  -- https://wezfurlong.org/wezterm/config/lua/config/show_new_tab_button_in_tab_bar.html
  show_new_tab_button_in_tab_bar = false,
  -- https://wezfurlong.org/wezterm/config/lua/config/show_tab_index_in_tab_bar.html
  show_tab_index_in_tab_bar = false,
  -- https://wezfurlong.org/wezterm/config/lua/config/show_tabs_in_tab_bar.html
  show_tabs_in_tab_bar = true,
  -- https://wezfurlong.org/wezterm/config/lua/config/window_decorations.html
  window_decorations = 'INTEGRATED_BUTTONS|RESIZE',
  -- https://wezfurlong.org/wezterm/config/lua/config/window_padding.html
  window_padding = { top = 0, right = 0, bottom = 0, left = 0 },
  -- https://wezfurlong.org/wezterm/config/lua/config/window_frame.html
  window_frame = {
    -- The font used in the tab bar.
    font = wezterm.font { family = 'Google Sans Display', weight = 'Medium' },
    -- The size of the font in the tab bar.
    font_size = 12.0,
    -- The overall background color of the tab bar when the window is focused.
    active_titlebar_bg = mrsuit.colors.background,
    -- The overall background color of the tab bar when the window is not focused.
    inactive_titlebar_bg = mrsuit.colors.background,
  },
  -- https://wezfurlong.org/wezterm/config/lua/config/tab_bar_style.html
  -- tab_bar_style = {},
  integrated_title_button_style = 'MacOsNative',
  -- Colorscheme load above and also used for the tab bar.
  colors = mrsuit.colors,
  -- Some common hyperlink rules.
  hyperlink_rules = {
    { regex = '\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b', format = '$0' },
    { regex = '\\b\\w+://(?:[\\w.-]+)\\S*\\b',               format = '$0' },
    { regex = '\\bfile://\\S*\\b',                           format = '$0' },
    { regex = '\\bb/(\\d+)\\b',                              format = 'https://b.corp.google.com/issues/$1' },
    {
      regex = '\\bcl/(\\d+)\\b',
      format = 'https://critique.corp.google.com/issues/$1',
    },
  },
}

return config
