return {
  -- Search engines.
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      -- 1st-party telescope plugins.
      { 'nvim-telescope/telescope-symbols.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'tsakirist/telescope-lazy.nvim' },
      { 'yamatsum/nvim-nonicons' },

      -- 3rd-party telescope plugins.
      { 'debugloop/telescope-undo.nvim' },
    },
    config = function()
      require 'telescope'.setup {
        defaults = {
          prompt_prefix = '   ',
          entry_prefix = '   ',
          selection_caret = '  ',
          layout_strategy = 'flex',

          file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
          grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
          qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,

          mappings = {
            i = {
              ['<esc>'] = require 'telescope.actions'.close,
              ['<C-x>'] = false,
              ['<C-q>'] = require 'telescope.actions'.send_to_qflist,
              ['<CR>'] = require 'telescope.actions'.select_default,
            },
          },
        },
      }

      require 'telescope'.load_extension 'fzf'
      require 'telescope'.load_extension 'lazy'
      require 'telescope'.load_extension 'undo'
    end,
    keys = {
      { '<LocalLeader>f', function() require 'telescope.builtin'.find_files() end },
      {
        '<LocalLeader><Space>',
        function()
          vim.fn.system [[ git rev-parse --is-inside-work-tree ]]
          if vim.v.shell_error == 0 then
            require 'telescope.builtin'.git_files()
          else
            require 'telescope.builtin'.find_files()
          end
        end,
      },
      { '<LocalLeader>g', function() require 'telescope.builtin'.live_grep() end },
      {
        '<LocalLeader>.',
        function()
          local opts = { cwd = '~/.config' }
          if vim.fn.executable 'rg' > 0 then
            opts.find_command = { 'rg', '--ignore', '--hidden', '--files' }
          elseif vim.fn.executable 'fd' > 0 then
            opts.find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' }
          end
          require 'telescope.builtin'.find_files(opts)
        end,
      },
      { '<LocalLeader>b',  require 'user.utils.telescope'.buffers },
      { '<LocalLeader>j',  function() require 'telescope.builtin'.jumplist() end },
      { '<LocalLeader>h',  function() require 'telescope.builtin'.highlights() end },
      { '<LocalLeader>s',  function() require 'telescope.builtin'.lsp_document_symbols() end },
      { '<LocalLeader>S',  function() require 'telescope.builtin'.lsp_dynamic_workspace_symbols() end },
      { '<LocalLeader>d',  function() require 'telescope.builtin'.diagnostics() end },
      { '<LocalLeader>/',  function() require 'telescope.builtin'.find_files() end },
      { '<LocalLeader>?',  function() require 'telescope.builtin'.help_tags() end },
      { '<LocalLeader>tm', function() require 'telescope.builtin'.man_pages() end },
      { '<LocalLeader>u',  function() require 'telescope'.extensions.undo.undo() end },
      { '<LocalLeader>*',  function() require 'telescope.builtin'.grep_string() end },
      { '<LocalLeader>L',  function() require 'telescope'.extensions.lazy.lazy() end },
    },
  },

  {
    'FeiyouG/commander.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    keys = {
      { '<C-p>', '<CMD>Telescope commander<CR>', mode = 'n' },
    },
    config = true,
  },

  {
    'Cassin01/wf.nvim',
    config = function()
      require 'wf'.setup { theme = 'space' }

      local which_key = require 'wf.builtin.which_key'
      local register = require 'wf.builtin.register'
      local bookmark = require 'wf.builtin.bookmark'
      local buffer = require 'wf.builtin.buffer'
      local mark = require 'wf.builtin.mark'

      -- Register
      vim.keymap.set(
        'n',
        '<Space>wr',
        -- register(opts?: table) -> function
        -- opts?: option
        register(),
        { noremap = true, silent = true, desc = '[wf.nvim] register' }
      )

      -- Bookmark
      vim.keymap.set(
        'n',
        '<Space>wbo',
        -- bookmark(bookmark_dirs: table, opts?: table) -> function
        -- bookmark_dirs: directory or file paths
        -- opts?: option
        bookmark {
          nvim = '~/.config/nvim',
          zsh = '~/.zshrc',
        },
        { noremap = true, silent = true, desc = '[wf.nvim] bookmark' }
      )

      -- Buffer
      vim.keymap.set(
        'n',
        '<Space>wbu',
        -- buffer(opts?: table) -> function
        -- opts?: option
        buffer(),
        { noremap = true, silent = true, desc = '[wf.nvim] buffer' }
      )

      -- Mark
      vim.keymap.set(
        'n',
        "'",
        -- mark(opts?: table) -> function
        -- opts?: option
        mark(),
        { nowait = true, noremap = true, silent = true, desc = '[wf.nvim] mark' }
      )

      -- Which Key
      vim.keymap.set(
        'n',
        '<Leader>',
        -- mark(opts?: table) -> function
        -- opts?: option
        which_key { text_insert_in_advance = '<Leader>' },
        { noremap = true, silent = true, desc = '[wf.nvim] which-key /', }
      )
    end,
  },
}
