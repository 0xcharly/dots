return {
  -- Common dependency.
  { 'nvim-lua/plenary.nvim' },

  --- Motions and other convenience plugins.
  { 'tpope/vim-repeat' },
  {
    'mbbill/undotree',
    keys = {
      { '<LocalLeader>ut', '<cmd>UndotreeToggle<cr>', desc = '[U]ndo [T]ree' },
    },
  },
  { 'asiryk/auto-hlsearch.nvim', event = 'BufReadPost', config = true },
  { 'kylechui/nvim-surround',    event = 'VeryLazy',    config = true },
  { 'numToStr/Comment.nvim',     lazy = false,          config = true },
  { 'ethanholz/nvim-lastplace',  lazy = false,          config = true },

  {
    -- Better increment/decrement.
    'monaqa/dial.nvim',
    keys = {
      { '<C-a>', function() return require 'dial.map'.inc_normal() end,  expr = true, desc = 'Increment' },
      { '<C-x>', function() return require 'dial.map'.dec_normal() end,  expr = true, desc = 'Decrement' },
    },
    config = function()
      local augend = require 'dial.augend'
      require 'dial.config'.augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias['%Y-%m-%d'],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      }
    end,
  },

  {
    -- Structural Search & Replace.
    'cshuaimin/ssr.nvim',
    keys = {
      { '<leader>ssr', function() require 'ssr'.open() end, mode = { 'n', 'x' }, desc = 'Structural Replace' },
    },
  },

  {
    -- 3-way diff-view.
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    config = true,
    keys = {
      { '<leader>dv', '<cmd>DiffviewOpen<cr>', desc = 'DiffView' },
    },
  },
}
