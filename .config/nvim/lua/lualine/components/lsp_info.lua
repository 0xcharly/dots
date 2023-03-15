local highlight = require 'lualine.highlight'
local colorscheme = require 'coalescence.palette'

local LspInfo = require('lualine.component'):extend()

STATUS_INIT = 0
STATUS_IN_PROGRESS = 1
STATUS_DONE = 2

LspInfo.default = {
  colors = {
    lsp_client_name = colorscheme.chroma.onSurface1,
    status_icon = colorscheme.chroma.skyBlueOnSurface,
  },
  component_sep = ' ',
  hide = { 'null-ls', 'pyright' },
  only_show_attached = true,
  status_icon = { initializing = '󰦖 ', ready = '󰲽 ' },
  max_message_length = 30,
}

-- Initializer
LspInfo.init = function(self, options)
  LspInfo.super.init(self, options)

  self.options.max_message_length = self.options.max_message_length or LspInfo.default.max_message_length
  self.options.colors = vim.tbl_extend('force', LspInfo.default.colors, self.options.colors or {})
  self.options.hide = self.options.hide or LspInfo.default.hide
  self.options.status_icon = vim.tbl_extend('force', LspInfo.default.status_icon, self.options.status_icon or {})

  self.highlights = { lsp_client_name = '', status_icon = '' }
  self.highlights.status_icon = highlight.create_component_highlight_group(
    { fg = self.options.colors.status_icon },
    'lspprogress_message',
    self.options
  )
  self.highlights.lsp_client_name = highlight.create_component_highlight_group(
    { fg = self.options.colors.lsp_client_name },
    'lspprogress_lsp_client_name',
    self.options
  )
  -- Setup callback to get updates from the lsp to update lualine.

  self:register_progress()
end

LspInfo.update_status = function(self)
  return self:update_progress()
end

LspInfo.suppress_server = function(self, name)
  if vim.tbl_contains(self.options.hide or {}, name) then return true end
  if self.options.only_show_attached then
    local clients = vim.tbl_map(
      function(c) return c.name end,
      vim.lsp.get_active_clients { bufnr = vim.api.nvim_get_current_buf() }
    )
    if not vim.tbl_contains(clients, name) then return true end
  end
  return false
end

LspInfo.register_progress = function(self)
  self.clients = {}

  self.progress_callback = function(msgs)
    for _, msg in ipairs(msgs) do
      local client_name = msg.name

      if self:suppress_server(client_name) then
        self.clients[client_name] = nil
      else
        if self.clients[client_name] == nil then self.clients[client_name] = { status = STATUS_INIT } end

        local progress = self.clients[client_name]

        if msg.done then
          progress.status = STATUS_DONE
        else
          progress.status = STATUS_IN_PROGRESS
        end
      end
    end
  end

  local gid = vim.api.nvim_create_augroup('LualineLspProgressEvent', { clear = true })
  vim.api.nvim_create_autocmd('User', {
    group = gid,
    pattern = { 'LspProgressUpdate' },
    callback = function() self.progress_callback(vim.lsp.util.get_progress_messages()) end,
  })

  local cached_attached = {}
  vim.api.nvim_create_autocmd('LspAttach', {
    group = gid,
    callback = function(args)
      local client_id = args.data.client_id
      if cached_attached[client_id] == nil then
        cached_attached[client_id] = true
        self.progress_callback {
          {
            done = false,
            name = vim.lsp.get_client_by_id(client_id).name,
          },
        }
      end
    end,
  })
  vim.api.nvim_create_autocmd('LspDetach', {
    group = gid,
    callback = function(args)
      local client_id = args.data.client_id
      cached_attached[client_id] = nil
    end,
  })
end

LspInfo.update_progress = function(self)
  local result = {}

  for client_name, client in pairs(self.clients) do
    -- Status icon.
    local status_icon = self.options.status_icon.ready
    if client.status == STATUS_INIT then status_icon = self.options.status_icon.initializing end
    table.insert(result, highlight.component_format_highlight(self.highlights.status_icon) .. status_icon)
    -- LSP client name.
    table.insert(result, highlight.component_format_highlight(self.highlights.lsp_client_name) .. client_name)
  end

  return table.concat(result, self.options.component_sep)
end

return LspInfo
