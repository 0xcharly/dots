local mrsuit = {}

mrsuit.colors = {
  -- The default text color
  foreground = '#b1c3d2',
  -- The default background color
  background = '#151b23',

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = '#90a4bb',
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = '#171c23',
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = '#90a4bb',

  -- the foreground color of selected text
  selection_fg = '#171c23',
  -- the background color of selected text
  selection_bg = '#94b2f6',

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = '#222222', -- TODO

  -- The color of the split lines between panes
  split = '#444444', -- TODO

  ansi = {
    '#86909f',
    '#fe9aa4',
    '#a8cba4',
    '#e6ddaf',
    '#8bb5da',
    '#b4befe',
    '#91d7d1',
    '#b2c4d3',
  },
  brights = {
    '#7a8490',
    '#fe7f8c',
    '#8ed29c',
    '#fab387',
    '#89b4fa',
    '#d0aff8',
    '#6fd0c6',
    '#8fa3bb',
  },

  -- Arbitrary colors of the palette in the range from 16 to 255
  -- indexed = { [136] = '#af8700' },

  -- Since: 20220319-142410-0fcdea07
  -- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = 'orange',

  -- Colors for copy_mode and quick_select
  -- available since: 20220807-113146-c2fee766
  -- In copy_mode, the color of the active text is:
  -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
  -- 2. selection_* otherwise
  copy_mode_active_highlight_bg = { Color = '#000000' },
  -- use `AnsiColor` to specify one of the ansi color palette values
  -- (index 0-15) using one of the names "Black", "Maroon", "Green",
  --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
  -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
  copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
  copy_mode_inactive_highlight_bg = { Color = '#52ad70' },
  copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },

  quick_select_label_bg = { Color = 'peru' },
  quick_select_label_fg = { Color = '#ffffff' },
  quick_select_match_bg = { AnsiColor = 'Navy' },
  quick_select_match_fg = { Color = '#ffffff' },

  tab_bar = {
    -- Fancy tab bar.
    -- The color of the inactive tab bar edge/divider.
    inactive_tab_edge = '#151b23',

    -- Retro tab bar.
    active_tab = {
      fg_color = '#9fcdfe',
      bg_color = '#19222f',
    },
    inactive_tab = {
      fg_color = '#7d8590',
      bg_color = '#21262d',
    },
    inactive_tab_hover = {
      fg_color = '#d3b5f2',
      bg_color = '#21202f',
    },
  },
}

return mrsuit
