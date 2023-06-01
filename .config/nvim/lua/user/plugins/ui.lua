-- UI-related plugins.

return {
  { 'rktjmp/lush.nvim', cmd = 'Lushify' },
  { 'rktjmp/shipwright.nvim', cmd = 'Shipwright' },

  {
    '0xcharly/chroma.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.cmd [[colorscheme chroma-static]]
    end,
  },

  -- Iconography.
  { 'nvim-tree/nvim-web-devicons', config = true },

  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'lualine'.setup {
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            {
              'filename',
              symbols = {
                modified = '󱇨 ', -- Text to show when the file is modified.
                readonly = '󱀰 ', -- Text to show when the file is non-modifiable or readonly.
                unnamed = '󰡯 ', -- Text to show for unnamed buffers.
                newfile = '󰻭 ', -- Text to show for newly created file before first write
              },
            },
          },
          lualine_c = {
            {
              'lsp_info',
              separator = '‥',
            },
            {
              'diagnostics',
              symbols = {
                error = require 'user.utils.lsp'.diagnostic_signs.Error,
                warn = require 'user.utils.lsp'.diagnostic_signs.Warn,
                info = require 'user.utils.lsp'.diagnostic_signs.Info,
                hint = require 'user.utils.lsp'.diagnostic_signs.Hint,
              },
            },
          },
          lualine_x = {
            {
              'diff',
              symbols = { added = '󱍭 ', modified = '󱨈 ', removed = '󱍪 ' },
              separator = '‥',
            },
            {
              'branch',
              icon = { '', align = 'right' },
              color = { fg = require 'lush_theme.palette'.chroma.onSurface1 },
            },
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      }
    end,
  },

  { 'lewis6991/gitsigns.nvim', config = true },
}
