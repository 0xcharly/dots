return {
  -- LSP config.
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'folke/neodev.nvim',   config = true }, -- Needs to be setup before lspconfig
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    config = function()
      local lspconfig = require 'lspconfig'
      local cmp_nvim_lsp = require 'cmp_nvim_lsp'

      local user_lsp_utils = require 'user.utils.lsp'

      -- Register servers.
      user_lsp_utils.clangd_setup(lspconfig, cmp_nvim_lsp)
      -- The DartLS server is already configured by the flutter-tools plugin.
      -- user_lsp_utils.dartls_setup(lspconfig, cmp_nvim_lsp)
      user_lsp_utils.lua_ls_setup(lspconfig, cmp_nvim_lsp)
      user_lsp_utils.pylsp_setup(lspconfig, cmp_nvim_lsp)

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
