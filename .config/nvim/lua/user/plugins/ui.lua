-- UI-related plugins.

return {
  { 'rktjmp/lush.nvim',       cmd = 'Lushify' },
  { 'rktjmp/shipwright.nvim', cmd = 'Shipwright' },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.cmd [[colorscheme catppuccin-mocha]]
    end,
  },

  -- Iconography.
  { 'nvim-tree/nvim-web-devicons', config = true },

  -- Git integration.
  { 'lewis6991/gitsigns.nvim',     config = true },

  -- Notifications.
  {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require 'notify'
      vim.notify.setup {
        max_width = 80,
        timeout = 2500,
        stages = 'fade',
        render = 'simple',
        fps = 60,
      }
    end,
  },

  -- Terminal manipulation.
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = {
      open_mapping = [[<c-j>]],
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
    }
  },

  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local section_filename = {
        'filename',
        symbols = {
          modified = '󱇨 ', -- Text to show when the file is modified.
          readonly = '󱀰 ', -- Text to show when the file is non-modifiable or readonly.
          unnamed = '󰡯 ', -- Text to show for unnamed buffers.
          newfile = '󰻭 ', -- Text to show for newly created file before first write
        },
      }
      require 'lualine'.setup {
        options = {
          theme = {
            normal = {
              a = 'LualineANormal',
              b = 'LualineBNormal',
              c = 'LualineCNormal',
              x = 'LualineXNormal',
              y = 'LualineYNormal',
              z = 'LualineZNormal',
            },
            insert = {
              a = 'LualineAInsert',
              b = 'LualineBInsert',
              c = 'LualineCInsert',
              x = 'LualineXInsert',
              y = 'LualineYInsert',
              z = 'LualineZInsert',
            },
            visual = {
              a = 'LualineAVisual',
              b = 'LualineBVisual',
              c = 'LualineCVisual',
              x = 'LualineXVisual',
              y = 'LualineYVisual',
              z = 'LualineZVisual',
            },
            replace = {
              a = 'LualineAReplace',
              b = 'LualineBReplace',
              c = 'LualineCReplace',
              x = 'LualineXReplace',
              y = 'LualineYReplace',
              z = 'LualineZReplace',
            },
            command = {
              a = 'LualineACommand',
              b = 'LualineBCommand',
              c = 'LualineCCommand',
              x = 'LualineXCommand',
              y = 'LualineYCommand',
              z = 'LualineZCommand',
            },
            inactive = {
              a = 'LualineAInactive',
              b = 'LualineBInactive',
              c = 'LualineCInactive',
              x = 'LualineXInactive',
              y = 'LualineYInactive',
              z = 'LualineZInactive',
            },
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { section_filename },
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
            },
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = { 'mode' },
          lualine_b = {},
          lualine_c = { section_filename },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
      }
    end,
  },
}
