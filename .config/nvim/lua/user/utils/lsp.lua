local M = {}

-- { error = '󰅗 󰅙 󰅘 󰅚 󱄊 ', warn = '󰀨 󰗖 󱇎 󱇏 󰲼 ', info = '󰋽 󱔢 ', hint = '󰲽 ' },
M.diagnostic_signs = {
  Error = '󰅚 ',
  Warn = '󰗖 ',
  Info = '󰋽 ',
  Hint = '󰲽 ',
}

function M.ui_tweaks()
  -- Leading icon on diagnostic virtual text.
  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = {
        spacing = 4,
        prefix = ' ',
      },
    })

  -- Bordered popups.
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = 'rounded' })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help, { border = 'rounded' })

  for type, icon in pairs(M.diagnostic_signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

-- This function gets run when an LSP connects to a particular buffer.
function M.user_on_attach(client, bufnr)
  -- Disable semantic tokens (overrides tree-sitter highlighting).
  -- client.server_capabilities.semanticTokensProvider = nil

  -- Buffer-specific keymap.
  local buf_opts = { buffer = bufnr }

  vim.keymap.set('n', '<LocalLeader>k', vim.lsp.buf.hover, buf_opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, buf_opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, buf_opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, buf_opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, buf_opts)
  vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, buf_opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, buf_opts)
  vim.keymap.set('n', '<LocalLeader>r', vim.lsp.buf.rename, buf_opts)
  vim.keymap.set('n', '<leader>cf', function()
    vim.lsp.buf.format { async = true, }
  end, buf_opts)
  vim.keymap.set('n', '<LocalLeader>a', vim.lsp.buf.code_action, buf_opts)
  vim.keymap.set('x', '<LocalLeader>a', vim.lsp.buf.code_action, buf_opts)

  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, buf_opts)

  vim.keymap.set('n', 'gl', vim.diagnostic.open_float, buf_opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, buf_opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, buf_opts)
end

function M.user_capabilities(cmp_nvim_lsp)
  -- nvim-cmp supports additional completion capabilities.
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  capabilities.textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  }
  return capabilities
end

M.dartls_settings = {
  lineLength = 100,
  renameFilesWithClasses = 'always',
}

-- Register Company LSP server (powered by local tool).
function M.ciderlsp_setup(lspconfig, cmp_nvim_lsp)
  require 'user.utils.company'.register_ciderlsp(lspconfig).setup {
    capabilities = M.user_capabilities(cmp_nvim_lsp),
    on_attach = M.user_on_attach,
  }
end

-- Register the C/C++ LSP (powered by clangd).
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd
-- https://clangd.llvm.org/installation.html
function M.clangd_setup(lspconfig, cmp_nvim_lsp)
  lspconfig.clangd.setup {
    capabilities = M.user_capabilities(cmp_nvim_lsp),
    on_attach = M.user_on_attach,
    settings = {},
  }
end

-- Register the Dart/Flutter LSP (powered by DartLS).
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#dartls
-- https://github.com/dart-lang/sdk/tree/master/pkg/analysis_server/tool/lsp_spec
function M.dartls_setup(lspconfig, cmp_nvim_lsp)
  lspconfig.dartls.setup {
    capabilities = M.user_capabilities(cmp_nvim_lsp),
    on_attach = M.user_on_attach,
    settings = M.dartls_settings,
  }
end

-- Register the Python LSP (powered by pylsp).
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
-- https://github.com/python-lsp/python-lsp-server
function M.pylsp_setup(lspconfig, cmp_nvim_lsp)
  lspconfig.pylsp.setup {
    capabilities = M.user_capabilities(cmp_nvim_lsp),
    on_attach = M.user_on_attach,
    settings = {
      pylsp = {
        plugins = {
          autopep8 = { enabled = false }, -- Required to use yapf.
          pycodestyle = {
            ignore = {
              'E126', -- TODO: figure out why.
              'W504', -- Line break after binary operator.
            },
            maxLineLength = 100,
            indentSize = 2,
          },
          rope_autoimport = { enabled = false },
          yapf = {
            enabled = true,
            args = '--style={based_on_style: google, indent_width: 2}',
          },
        }
      },
    },
  }
end

-- Register the Lua server (powered by lua-language-server).
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
-- https://github.com/luals/lua-language-server
function M.lua_ls_setup(lspconfig, cmp_nvim_lsp)
  lspconfig.lua_ls.setup {
    capabilities = M.user_capabilities(cmp_nvim_lsp),
    on_attach = M.user_on_attach,
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        format = {
          enable = true,
          defaultConfig = {
            call_arg_parentheses = 'remove',
            indent_style = 'space',
            quote_style = 'single',
          },
        },
      },
    },
  }
end

return M
