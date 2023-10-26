local wezterm = require 'wezterm'

local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- If the tab title is explicitly set, take that.
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane in that tab.
  return tab_info.active_pane.title
end

local LEFT_SLANT = wezterm.nerdfonts.ple_lower_right_triangle
local RIGHT_SLANT = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local tab_bar_background = config.resolved_palette.ansi[8]
    local intensity = 'Normal'
    local index_color = config.resolved_palette.brights[8]
    local title_color = config.resolved_palette.brights[8]

    if tab.is_active then
      intensity = 'Bold'
      index_color = config.resolved_palette.ansi[2]
      title_color = config.resolved_palette.foreground
    end

    local title = tab_title(tab)
    local index_prefix = string.format('%d:', tab.tab_index)
    local title_with_index = string.format('%s %s', index_prefix, title)

    -- Ensure that the titles fit in the available space, and that we have room
    -- for the edges.
    local fitted_title = wezterm.truncate_right(title, max_width - 4)
    local fitted_title_with_index = wezterm.truncate_right(title_with_index, max_width - 4)
    if fitted_title_with_index ~= title_with_index then
      -- Add an ellipsis if the text was truncated.
      fitted_title = wezterm.truncate_right(fitted_title, #fitted_title_with_index - #index_prefix - 2) .. '…'
    end

    return {
      { Background = { Color = tab_bar_background } },
      { Foreground = { Color = config.resolved_palette.background } },
      { Text = LEFT_SLANT },
      { Background = { Color = config.resolved_palette.background } },
      { Foreground = { Color = index_color } },
      { Attribute = { Intensity = intensity } },
      { Text = ' ' },
      { Text = index_prefix },
      { Foreground = { Color = title_color } },
      { Text = ' ' .. fitted_title .. ' ' },
      { Background = { Color = tab_bar_background } },
      { Foreground = { Color = config.resolved_palette.background } },
      { Text = RIGHT_SLANT },
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
-- https://wezfurlong.org/wezterm/config/lua/config/tab_max_width.html
config.tab_max_width = 32
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
local catppuccin_mocha = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
wezterm.plugin.require 'https://github.com/catppuccin/wezterm'.apply_to_config(config, {
  accent = 'lavender',
  token_overrides = {
    mocha = {
      tab_bar = {
        background = catppuccin_mocha.ansi[8],
      },
    },
  },
})

return config
