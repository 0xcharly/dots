local M = {}

local google3_home = '/google/src/cloud/delay/'

function M.setup()
  local google3_filetype_group = vim.api.nvim_create_augroup('Google3Filetype', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    group = google3_filetype_group,
    pattern = { google3_home .. '*.java', google3_home .. '*.kt' },
    command = 'set sw=2 ts=2 sts=2 tw=100',
  })
end

function M.is_corporate_host() return vim.loop.fs_stat(google3_home) ~= nil end

function M.register_ciderlsp(lspconfig)
  local ciderlsp_cmp = {
    '/google/bin/releases/cider/ciderlsp/ciderlsp',
    '--tooltag=nvim-lsp',
    '--noforward_sync_responses',
    '--websocket_host=ciderlsp-staging.corp.google.com',
  }
  if vim.fn.executable('mdproxy') > 0 then
    table.insert(ciderlsp_cmp, 1, 'mdproxy')
  end
  -- Custom configuration for CiderLSP.
  require('lspconfig.configs').ciderlsp = {
    default_config = {
      cmd = ciderlsp_cmp,
      filetypes = {
        'c',
        'cpp',
        'java',
        'kotlin',
        'proto',
        'textproto',
        'go',
        'python',
        'bzl',
        'objc',
        'typescript',
        'javascript',
      },
      root_dir = function(fname) return string.match(fname, '(/google/src/cloud/[%w_-]+/[%w_-]+/google3/).+$') end,
      settings = {},
    },
  }
  return lspconfig.ciderlsp
end

function M.path_display(opts, path)
  -- Do common substitutions.
  -- Google3 generic.
  path = path:gsub('^/google/src/cloud/[^/]+/[^/]+/google3/', 'google3/', 1)
  path = path:gsub('^google3/java/com/google/', 'g3/jcg/', 1)
  path = path:gsub('^google3/javatests/com/google/', 'g3/jtcg/', 1)
  path = path:gsub('^google3/third_party/', 'g3/3rdp/', 1)
  path = path:gsub('^google3/', 'g3/', 1)

  -- GMM specific.
  path = path:gsub('^g3/jcg/apps/android/gmm', 'agmm/', 1)
  path = path:gsub('^g3/jtcg/apps/android/gmm', 'agmm/tests/', 1)

  -- Do truncation. This allows us to combine our custom display formatter with the built-in truncation.
  -- `truncate` handler in transform_path memoizes computed truncation length in opts.__length.
  -- Here we are manually propagating this value between new_opts and opts.
  -- We can make this cleaner and more complicated using metatables :)
  local new_opts = {
    path_display = {
      truncate = true,
    },
    __length = opts.__length,
  }
  path = require('telescope.utils').transform_path(new_opts, path)
  opts.__length = new_opts.__length
  return path
end

return M
