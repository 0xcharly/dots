-- UI-related plugins.

return {
  { -- Colorscheme: Coalescence
    '0xcharly/coalescence.nvim',
    dependencies = { 'tjdevries/colorbuddy.nvim' },
    dev = true,
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      require('colorbuddy').colorscheme 'coalescence'
    end,
  },

  -- Iconography.
  { 'nvim-tree/nvim-web-devicons', config = true },

  { -- Nicer UI primitives.
    'folke/noice.nvim',
    dependencies = 'MunifTanjim/nui.nvim',
    event = 'VeryLazy',
    opts = {
      cmdline = {
        format = {
          cmdline = { pattern = '^:', icon = ': ', lang = 'vim' },
          filter = { pattern = '^:%s*!', icon = ' ', lang = 'bash' },
          help = { pattern = '^:%s*he?l?p?%s+', icon = ' ' },
          lua = { pattern = '^:%s*lua%s+', icon = ' ', lang = 'lua' },
        },
      },
      messages = {
        enabled = true,
        view_search = false,
      },
      popupmenu = {
        backend = 'cmp',
      },
      presets = {
        lsp_doc_border = true,
        inc_rename = true,
      },
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
    },
  },

  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
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
                error = require('user.utils.lsp').diagnostic_signs.Error,
                warn = require('user.utils.lsp').diagnostic_signs.Warn,
                info = require('user.utils.lsp').diagnostic_signs.Info,
                hint = require('user.utils.lsp').diagnostic_signs.Hint,
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
              color = { fg = require('coalescence.palette').chroma.onSurface1 },
            },
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      }
    end,
  },

  { 'lewis6991/gitsigns.nvim', config = true },

  {
    'folke/trouble.nvim',
    config = function()
      local signs = require('user.utils.lsp').diagnostic_signs
      require('trouble').setup {
        signs = {
          error = signs.Error,
          warning = signs.Warn,
          hint = signs.Hint,
          information = signs.Info,
          other = '﫠',
        },
      }
    end,
  },

  { -- Scrollbar.
    'petertriho/nvim-scrollbar',
    event = 'BufReadPost',
    config = true,
  },
}
