return {
  -- Search engines.
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      -- 1st-party telescope plugins.
      { 'nvim-telescope/telescope-symbols.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'tsakirist/telescope-lazy.nvim' },
      { 'yamatsum/nvim-nonicons' },

      -- 3rd-party telescope plugins.
      { 'debugloop/telescope-undo.nvim' },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          prompt_prefix = '   ',
          entry_prefix = '   ',
          selection_caret = ' ❯ ',
          layout_strategy = 'flex',

          file_previewer = require('telescope.previewers').vim_buffer_cat.new,
          grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
          qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

          mappings = {
            i = {
              ['<esc>'] = require('telescope.actions').close,
              ['<C-x>'] = false,
              ['<C-q>'] = require('telescope.actions').send_to_qflist,
              ['<CR>'] = require('telescope.actions').select_default,
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      require('telescope').load_extension 'flutter'
      require('telescope').load_extension 'fzf'
      require('telescope').load_extension 'harpoon'
      require('telescope').load_extension 'lazy'
      require('telescope').load_extension 'noice'
      require('telescope').load_extension 'undo'
      require('telescope').load_extension 'ui-select'
    end,
    keys = {
      -- Available through fzf-lua if necessary (ie. for performances reason).
      { '<leader>ff', function() require('telescope.builtin').find_files() end },
      {
        '<leader>c',
        function()
          vim.fn.system [[ git rev-parse --is-inside-work-tree ]]
          if vim.v.shell_error == 0 then
            require('telescope.builtin').git_files()
          else
            require('telescope.builtin').find_files()
          end
        end,
      },
      { '<leader>g', function() require('telescope.builtin').live_grep() end },
      {
        '<leader>.',
        function()
          local opts = { cwd = '~/.config' }
          if vim.fn.executable 'rg' > 0 then
            opts.find_command = { 'rg', '--ignore', '--hidden', '--files' }
          elseif vim.fn.executable 'fd' > 0 then
            opts.find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' }
          end
          require('telescope.builtin').find_files(opts)
        end,
      },
      -- Telescope only.
      { '<leader>b', require('user.utils.telescope').buffers },
      { '<LocalLeader>ld', function() require('telescope.builtin').diagnostics() end },
      { '<leader>F', function() require('telescope').extensions.flutter.commands() end },
      { '<leader>L', function() require('telescope').extensions.lazy.lazy() end },
      { '<leader>tm', function() require('telescope.builtin').man_pages() end },
      { '<LocalLeader>ts', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end },
      { '<leader>su', function() require('telescope').extensions.undo.undo() end },
      { '<leader>*', function() require('telescope.builtin').grep_string() end },
      { '<leader>/', function() require('telescope.builtin').find_files() end },
      { '<leader>?', function() require('telescope.builtin').help_tags() end },
    },
  },

  --[[
    { -- FZF-based fuzzy finder (more responsive).
        'ibhagwan/fzf-lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        keys = {
            { '<leader>ff', function() require 'fzf-lua'.files() end },
            { '<C-p>', function() require 'fzf-lua'.git_files() end },
            { '<leader>g', function() require 'fzf-lua'.live_grep() end },
            {
                '<leader>.',
                function()
                    if vim.fn.executable 'fd' > 0 then
                        require 'fzf-lua'.files { cmd = 'fd . ~/.config --type f' }
                    else
                        require 'fzf-lua'.files { cwd = '~/.config' }
                    end
                end
            },
        },
    },
    ]]
}
