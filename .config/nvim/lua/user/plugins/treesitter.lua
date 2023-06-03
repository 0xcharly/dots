return {
  { -- Language syntaxes.
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' },
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'JoosepAlviste/nvim-ts-context-commentstring' },
    },
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {
          'beancount',
          'c',
          -- 'comment', -- PERF: Huge performance drop when using `comment`.
          'cpp',
          'diff',
          'help',
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
          'yaml',
        },
        highlight = { enable = true },
        indent = { enable = true, disable = { 'python' } },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<leader>v', -- maps in normal mode to init the node/scope selection
            node_incremental = '<leader>v', -- increment to the upper named parent
            node_decremental = '<leader>V', -- decrement to the previous node
            scope_incremental = 'grc', -- increment to the upper scope (as defined in locals.scm)
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
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = true, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        },
      }
    end,
  },
}
