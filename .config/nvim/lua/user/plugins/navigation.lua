return {
  -- Search engines.
  -- {
  --   'nvim-telescope/telescope.nvim',
  --   dependencies = {
  --     -- 1st-party telescope plugins.
  --     { 'nvim-telescope/telescope-symbols.nvim' },
  --     { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  --     { 'nvim-telescope/telescope-ui-select.nvim' },
  --     { 'tsakirist/telescope-lazy.nvim' },
  --     { 'yamatsum/nvim-nonicons' },
  --
  --     -- 3rd-party telescope plugins.
  --     { 'debugloop/telescope-undo.nvim' },
  --   },
  --   config = function()
  --     require('telescope').setup {
  --       defaults = {
  --         prompt_prefix = '   ',
  --         entry_prefix = '   ',
  --         selection_caret = ' ❯ ',
  --         layout_strategy = 'flex',
  --
  --         file_previewer = require('telescope.previewers').vim_buffer_cat.new,
  --         grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
  --         qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
  --
  --         mappings = {
  --           i = {
  --             ['<esc>'] = require('telescope.actions').close,
  --             ['<C-x>'] = false,
  --             ['<C-q>'] = require('telescope.actions').send_to_qflist,
  --             ['<CR>'] = require('telescope.actions').select_default,
  --           },
  --         },
  --       },
  --       extensions = {
  --         ['ui-select'] = {
  --           require('telescope.themes').get_dropdown(),
  --         },
  --       },
  --     }
  --
  --     require('telescope').load_extension 'fzf'
  --     require('telescope').load_extension 'lazy'
  --     require('telescope').load_extension 'undo'
  --     require('telescope').load_extension 'ui-select'
  --   end,
  --   keys = {
  --     -- Available through fzf-lua if necessary (ie. for performances reason).
  --     { '<LocalLeader>f', function() require('telescope.builtin').find_files() end },
  --     {
  --       '<LocalLeader>F',
  --       function()
  --         vim.fn.system [[ git rev-parse --is-inside-work-tree ]]
  --         if vim.v.shell_error == 0 then
  --           require('telescope.builtin').git_files()
  --         else
  --           require('telescope.builtin').find_files()
  --         end
  --       end,
  --     },
  --     { '<LocalLeader>g', function() require('telescope.builtin').live_grep() end },
  --     {
  --       '<LocalLeader>.',
  --       function()
  --         local opts = { cwd = '~/.config' }
  --         if vim.fn.executable 'rg' > 0 then
  --           opts.find_command = { 'rg', '--ignore', '--hidden', '--files' }
  --         elseif vim.fn.executable 'fd' > 0 then
  --           opts.find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' }
  --         end
  --         require('telescope.builtin').find_files(opts)
  --       end,
  --     },
  --     -- Telescope only.
  --     { '<LocalLeader>b', require('user.utils.telescope').buffers },
  --     { '<LocalLeader>j', function() require('telescope.builtin').jumplist() end },
  --     { '<LocalLeader>s', function() require('telescope.builtin').lsp_document_symbols() end },
  --     { '<LocalLeader>S', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end },
  --     { '<LocalLeader>d', function() require('telescope.builtin').diagnostics() end },
  --     { '<LocalLeader>/', function() require('telescope.builtin').find_files() end },
  --     { '<LocalLeader>?', function() require('telescope.builtin').help_tags() end },
  --
  --     { '<LocalLeader>tm', function() require('telescope.builtin').man_pages() end },
  --     { '<LocalLeader>u', function() require('telescope').extensions.undo.undo() end },
  --     { '<LocalLeader>*', function() require('telescope.builtin').grep_string() end },
  --     { '<LocalLeader>L', function() require('telescope').extensions.lazy.lazy() end },
  --   },
  -- },

  -- FZF-based fuzzy finder (more responsive).
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = {
      -- Disable icons.
      global_git_icons = false,
      global_file_icons = false,
      winopts = {
        border  = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
        preview = {
          title_align = 'center',
          scrollbar = 'float',
        },
      },
      fzf_opts = {
        ['--ansi']         = '',
        ['--info']         = 'inline',
        ['--height']       = '100%',
        ['--layout']       = 'reverse',
        ['--border']       = 'none',
        ['--prompt']       = '❯',
        ['--pointer']      = '❯',
        ['--marker']       = '❯',
        ['--no-scrollbar'] = '',
      },
      fzf_colors = {
        ['fg'] = { 'fg', 'FzfLuaColorsFg' },
        ['fg+'] = { 'fg', 'FzfLuaColorsFgSel', 'reverse:-1' },
        ['bg'] = { 'fg', 'FzfLuaColorsBg' },
        ['bg+'] = { 'fg', 'FzfLuaColorsBgSel' },
        ['hl'] = { 'fg', 'FzfLuaColorsHl' },
        ['hl+'] = { 'fg', 'FzfLuaColorsHlSel', 'underline:reverse:-1' },
        ['info'] = { 'fg', 'FzfLuaColorsInfo' },
        ['gutter'] = { 'fg', 'FzfLuaColorsGutter' },
        ['prompt'] = { 'fg', 'FzfLuaColorsPrompt' },
        ['pointer'] = { 'fg', 'FzfLuaColorsPointer' },
        ['marker'] = { 'fg', 'FzfLuaColorsMarker' },
        ['spinner'] = { 'fg', 'FzfLuaColorsSpinner' },
        ['header'] = { 'fg', 'FzfLuaColorsHeader' },
      },
      keymap = {
        builtin = {
          ['<S-up>']   = 'preview-page-up',
          ['<S-down>'] = 'preview-page-down',
        }, -- Delete all defaults.
        fzf = {
          -- fzf '--bind=' options
          ['ctrl-d']     = 'abort',
          ['ctrl-u']     = 'unix-line-discard',
          ['ctrl-f']     = 'half-page-down',
          ['ctrl-b']     = 'half-page-up',
          ['ctrl-a']     = 'beginning-of-line',
          ['ctrl-e']     = 'end-of-line',
          ['alt-a']      = 'toggle-all',
          -- Only valid with fzf previewers (bat/cat/git/etc)
          ['shift-down'] = 'preview-page-down',
          ['shift-up']   = 'preview-page-up',
        },
      },
      previewers = {
        builtin = {
          extensions = {
            png = { 'viu', '-b' },
            jpg = { 'kitty', '+kitten', 'icat' },
            jpeg = { 'kitty', '+kitten', 'icat' },
          }
        }
      },
    },
    keys = {
      -- "Smart" .files: calls git_files() if in a repository, files() otherwise.
      { '<LocalLeader><space>', function()
        local fzf_lua = require 'fzf-lua'
        local git_root = fzf_lua.path.git_root({}, true)
        if not git_root then return fzf_lua.files() end
        return fzf_lua.git_files()
      end },
      { '<LocalLeader>f', function() require 'fzf-lua'.files() end },
      { '<LocalLeader>j', function() require 'fzf-lua'.jumps() end },
      { '<LocalLeader>z', function() require 'fzf-lua'.builtin() end },
      { '<LocalLeader>b', function() require 'fzf-lua'.buffers() end },
      { '<C-p>',          function() require 'fzf-lua'.git_files() end },
      { '<LocalLeader>g', function() require 'fzf-lua'.live_grep() end },
      { '<LocalLeader>h', function() require 'fzf-lua'.highlights() end },
      { '<LocalLeader>?', function() require 'fzf-lua'.help_tags() end },
      { '<LocalLeader>s', function() require 'fzf-lua'.lsp_document_symbols() end },
      { '<LocalLeader>S', function() require 'fzf-lua'.lsp_dynamic_workspace_symbols() end },
      {
        '<LocalLeader>.',
        function()
          require 'fzf-lua'.files {
            prompt = '.files  ',
            cwd_prompt = false,
            fd_opts = '--type f --exclude raycast/ --exclude vcsh/',
            rg_opts = "--color=always --smart-case -g '!{raycast,vcsh}/'",
            find_opts = "-type f -not -path '*/vcsh/*' -not -path '*/raycast/*'",
            cwd = '~/.config',
          }
        end
      },
    },
  },
}
