return {
  -- Common dependency.
  { 'nvim-lua/plenary.nvim' },

  --- Motions and other convenience plugins.
  { 'tpope/vim-repeat' },
  { 'asiryk/auto-hlsearch.nvim', event = 'BufReadPost', config = true },
  { 'kylechui/nvim-surround',    event = 'VeryLazy',    config = true },
  { 'numToStr/Comment.nvim',     lazy = false,          config = true },
  { 'ethanholz/nvim-lastplace',  lazy = false,          config = true },
}
