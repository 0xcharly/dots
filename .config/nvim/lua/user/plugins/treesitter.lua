return {
  { -- Language syntaxes.
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'JoosepAlviste/nvim-ts-context-commentstring' },
    },
    build = ':TSUpdate',
    config = function() ---@diagnostic disable: missing-fields
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {
          'bash',
          'beancount',
          'c',
          -- 'comment', -- PERF: Huge performance drop when using `comment`.
          'cpp',
          'dart',
          'diff',
          'fish',
          'java',
          'json',
          'kotlin',
          'lua',
          'markdown',
          'markdown_inline',
          'python',
          'regex',
          'rst',
          'rust',
          'sql',
          'vimdoc',
          'yaml',
        },
        sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
        auto_install = false, -- Automatically install missing parsers when entering buffer
        highlight = { enable = true },
        -- Disabled for Dart until #4945 is resolved.
        -- TODO: reenable when resolved.
        -- https://github.com/nvim-treesitter/nvim-treesitter/issues/4945
        -- https://www.reddit.com/r/nvim/comments/147u8ln/nvim_lags_when_a_dart_file_is_opened/
        indent = { enable = true, disable = { 'dart', 'python' } },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<leader>v',   -- maps in normal mode to init the node/scope selection
            node_incremental = '<leader>v', -- increment to the upper named parent
            node_decremental = '<leader>V', -- decrement to the previous node
            scope_incremental = 'grc',      -- increment to the upper scope (as defined in locals.scm)
          },
        },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['aC'] = '@conditional.outer',
              ['iC'] = '@conditional.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }
    end,
  },
}
