local wezterm = require 'wezterm'

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

local function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

-- package.path = package.path .. ';/Users/delay'
-- local inspect = require 'inspect'

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
     -- wezterm.log_warn(string.format("%s", inspect(config)));
    local tab_bar_colors = config.resolved_palette.tab_bar
    local edge_background = '#0b0022'
    local background = tab_bar_colors.background
    local foreground = '#808080'

    if tab.is_active then
      background = tab_bar_colors.active_tab.bg_color
      foreground = tab_bar_colors.active_tab.fg_color
    elseif hover then
      background = tab_bar_colors.inactive_tab_hover.bg_color
      foreground = tab_bar_colors.inactive_tab_hover.fg_color
    end

    local edge_foreground = background

    local title = tab_title(tab)

    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    title = wezterm.truncate_right(title, max_width - 2)

    return {
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_LEFT_ARROW },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_RIGHT_ARROW },
    }
  end
)

-- Create config object.
local config = wezterm.config_builder()

-- https://wezfurlong.org/wezterm/config/lua/config/font.html
config.font = wezterm.font_with_fallback {
  -- 'PragmataPro Mono Liga',
  -- 'Fira Code',
  'Berkeley Mono',
  'Symbols Nerd Font',
  'Material Design Icons Desktop',
  'Noto Serif JP',
}
-- https://wezfurlong.org/wezterm/config/lua/config/font_size.html
-- Font size 14 for the best rendering.  Might be on the smaller side at some
-- DPI/screen resolutions.
config.font_size = 14
-- https://wezfurlong.org/wezterm/config/lua/config/bold_brightens_ansi_colors.html
config.bold_brightens_ansi_colors = false
-- https://wezfurlong.org/wezterm/config/lua/config/enable_tab_bar.html
config.enable_tab_bar = true
-- https://wezfurlong.org/wezterm/config/lua/config/use_fancy_tab_bar.html
config.use_fancy_tab_bar = false
-- https://wezfurlong.org/wezterm/config/lua/config/tab_bar_at_bottom.html?h=tab_bar
config.tab_bar_at_bottom = false
-- https://wezfurlong.org/wezterm/config/lua/config/hide_tab_bar_if_only_one_tab.html
config.hide_tab_bar_if_only_one_tab = false
-- https://wezfurlong.org/wezterm/config/lua/config/show_new_tab_button_in_tab_bar.html
config.show_new_tab_button_in_tab_bar = false
-- https://wezfurlong.org/wezterm/config/lua/config/show_tab_index_in_tab_bar.html
config.show_tab_index_in_tab_bar = true
-- https://wezfurlong.org/wezterm/config/lua/config/show_tabs_in_tab_bar.html
config.show_tabs_in_tab_bar = true
-- https://wezfurlong.org/wezterm/config/lua/config/window_decorations.html
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
-- https://wezfurlong.org/wezterm/config/lua/config/integrated_title_buttons.html
config.integrated_title_buttons = { 'Close' }
-- https://wezfurlong.org/wezterm/config/lua/config/integrated_title_button_style.html
config.integrated_title_button_style = 'Gnome'
-- https://wezfurlong.org/wezterm/config/lua/config/window_padding.html
--window_padding = { top = 48 },
-- Some common hyperlink rules.
config.hyperlink_rules = {
  { regex = '\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b', format = '$0' },
  { regex = '\\b\\w+://(?:[\\w.-]+)\\S*\\b',               format = '$0' },
  { regex = '\\bfile://\\S*\\b',                           format = '$0' },
  { regex = '\\bb/(\\d+)\\b',                              format = 'https://b.corp.google.com/issues/$1' },
  {
    regex = '\\bcl/(\\d+)\\b',
    format = 'https://critique.corp.google.com/issues/$1',
  },
}

-- Catppuccin theme using Wezterm's experimental plugin support.
wezterm.plugin.require 'https://github.com/catppuccin/wezterm'.apply_to_config(config, {
  accent = 'lavender',
})

return config
