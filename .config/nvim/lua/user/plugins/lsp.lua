return {
  -- LSP config.
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'folke/neodev.nvim',   config = true }, -- Needs to be setup before lspconfig.
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    config = function()
      local lspconfig = require 'lspconfig'
      local cmp_nvim_lsp = require 'cmp_nvim_lsp'

      local user_lsp_utils = require 'user.utils.lsp'

      -- Register servers.
      user_lsp_utils.clangd_setup(lspconfig, cmp_nvim_lsp)
      user_lsp_utils.dartls_setup(lspconfig, cmp_nvim_lsp)
      user_lsp_utils.lua_ls_setup(lspconfig, cmp_nvim_lsp)

      user_lsp_utils.ui_tweaks() -- Adjust UI.
    end,
  },

  {
    -- Enrich Rust development.
    'simrat39/rust-tools.nvim',
    dependencies = { 'mfussenegger/nvim-dap' },
    ft = 'rust',
    opts = {
      server = {
        on_attach = require 'user.utils.lsp'.user_on_attach,
      },
      tools = {
        inlay_hints = { highlight = 'LspCodeLens' },
      },
    },
  },

  -- Enrich Dart/Flutter development.
  {
    'akinsho/flutter-tools.nvim',
    lazy = false, -- TODO: Figure out the right laziness for this plugin.
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',   -- optional for vim.ui.select
    },
    config = true,
  },

  {
    -- Incremental LSP rename.
    'smjonas/inc-rename.nvim',
    cmd = 'IncRename',
    config = true,
    keys = {
      {
        '<LocalLeader>R',
        function()
          return ':IncRename ' .. vim.fn.expand '<cword>'
        end,
        expr = true,
        desc = '[R]ename (LSP)'
      },
    },
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local nls = require 'null-ls'
      nls.setup {
        debounce = 150,
        save_after_format = false,
        on_attach = require 'user.utils.lsp'.user_on_attach,
        sources = {
          nls.builtins.formatting.fish_indent,
          nls.builtins.formatting.jq,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.bean_format,
          nls.builtins.diagnostics.fish,
          nls.builtins.formatting.prettierd.with {
            filetypes = { 'markdown' }, -- only runs `deno fmt` for markdown
          },
        },
      }
    end,
  },
}
