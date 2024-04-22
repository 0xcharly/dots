local wezterm = require 'wezterm'

local LEFT_SLANT = wezterm.nerdfonts.ple_lower_right_triangle
local RIGHT_SLANT = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on(
  'format-tab-title',
---@diagnostic disable-next-line: unused-local
  function(tab, tabs, panes, config, hover, max_width)
    local palette = config.resolved_palette
    local tab_bar_background = palette.ansi[8]

    return {
      { Background = { Color = tab_bar_background } },
      { Foreground = { Color = palette.background } },
      { Text = LEFT_SLANT },
      { Background = { Color = palette.background } },
      { Foreground = { Color = tab.is_active and palette.ansi[2] or palette.brights[8] } },
      { Attribute = { Intensity = tab.is_active and 'Bold' or 'Normal'  } },
      { Text = string.format(' %d ', tab.tab_index) },
      { Background = { Color = tab_bar_background } },
      { Foreground = { Color = palette.background } },
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
  -- 'Victor Mono',
  -- 'Dank Mono',
  -- 'Berkeley Mono',
  'Iosevka Term Curly',
  'CommitMono',
  'Symbols Nerd Font',
  'Material Design Icons Desktop',
  'Motomachi',
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
config.tab_bar_at_bottom = true
-- https://wezfurlong.org/wezterm/config/lua/config/tab_max_width.html
config.tab_max_width = 32
-- https://wezfurlong.org/wezterm/config/lua/config/hide_tab_bar_if_only_one_tab.html
config.hide_tab_bar_if_only_one_tab = false
-- https://wezfurlong.org/wezterm/config/lua/config/show_new_tab_button_in_tab_bar.html
config.show_new_tab_button_in_tab_bar = false
-- https://wezfurlong.org/wezterm/config/lua/config/window_decorations.html
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
-- https://wezfurlong.org/wezterm/config/lua/config/initial_cols.html
config.initial_cols = 120
-- https://wezfurlong.org/wezterm/config/lua/config/initial_rows.html
config.initial_rows = 50
-- https://wezfurlong.org/wezterm/config/lua/config/window_padding.html
config.window_padding = { top = 48, left = 0, right = 0, bottom = 0 }
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
