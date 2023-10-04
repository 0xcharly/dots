local wezterm = require 'wezterm'

local config = {
  -- https://wezfurlong.org/wezterm/config/lua/config/font.html
  font = wezterm.font_with_fallback {
    -- 'PragmataPro Mono Liga',
    -- 'Fira Code',
    'Berkeley Mono',
    'Symbols Nerd Font',
    'Material Design Icons Desktop',
    'Noto Serif JP',
  },
  -- https://wezfurlong.org/wezterm/config/lua/config/font_size.html
  -- Font size 14 for the best rendering.  Might be on the smaller side at some
  -- DPI/screen resolutions.
  font_size = 14,
  -- https://wezfurlong.org/wezterm/config/lua/config/bold_brightens_ansi_colors.html
  bold_brightens_ansi_colors = false,
  -- https://wezfurlong.org/wezterm/config/lua/config/enable_tab_bar.html
  enable_tab_bar = true,
  -- https://wezfurlong.org/wezterm/config/lua/config/use_fancy_tab_bar.html
  use_fancy_tab_bar = false,
  -- https://wezfurlong.org/wezterm/config/lua/config/tab_bar_at_bottom.html?h=tab_bar
  tab_bar_at_bottom = true,
  -- https://wezfurlong.org/wezterm/config/lua/config/hide_tab_bar_if_only_one_tab.html
  hide_tab_bar_if_only_one_tab = true,
  -- https://wezfurlong.org/wezterm/config/lua/config/show_new_tab_button_in_tab_bar.html
  show_new_tab_button_in_tab_bar = false,
  -- https://wezfurlong.org/wezterm/config/lua/config/show_tab_index_in_tab_bar.html
  show_tab_index_in_tab_bar = true,
  -- https://wezfurlong.org/wezterm/config/lua/config/show_tabs_in_tab_bar.html
  show_tabs_in_tab_bar = true,
  -- https://wezfurlong.org/wezterm/config/lua/config/window_decorations.html
  window_decorations = 'RESIZE',
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

-- Catppuccin theme using Wezterm's experimental plugin support.
wezterm.plugin.require 'https://github.com/catppuccin/wezterm'.apply_to_config(config, {
  accent = 'lavender',
})

return config
