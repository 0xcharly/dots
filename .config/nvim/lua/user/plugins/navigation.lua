return {
  {
    'github/copilot.vim',
    cond = not require 'user.utils.company'.is_corporate_host(),
  },

  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>xx', function() require 'trouble'.toggle() end },
      { '<leader>xw', function() require 'trouble'.toggle 'workspace_diagnostics' end },
      { '<leader>xd', function() require 'trouble'.toggle 'document_diagnostics' end },
      { '<leader>xq', function() require 'trouble'.toggle 'quickfix' end },
      { '<leader>xl', function() require 'trouble'.toggle 'loclist' end },
      { 'gR',         function() require 'trouble'.toggle 'lsp_references' end },
    },
  },

  {
    'theprimeagen/harpoon',
    config = function() require 'harpoon':setup() end,
    keys = {
      { '<leader>a', function() require 'harpoon':list():append() end },
      { '<C-e>', function()
        local harpoon = require 'harpoon'
        harpoon.ui():toggle_quick_menu(harpoon:list())
      end },
      { '<C-h>',     function() require 'harpoon':list():select(1) end },
      { '<C-j>',     function() require 'harpoon':list():select(2) end },
      { '<C-k>',     function() require 'harpoon':list():select(3) end },
      { '<C-l>',     function() require 'harpoon':list():select(4) end },
    },
  },

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
            n = { ['<c-t>'] = require 'trouble.providers.telescope'.open_with_trouble },
            i = {
              ['<c-t>'] = require 'trouble.providers.telescope'.open_with_trouble,
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
}
