local M = {}

function M.buffers(opts)
  opts = opts or {}
  opts.previewer = false
  opts.attach_mappings = function(prompt_bufnr, map)
    local delete_buf = function()
      local action_state = require 'telescope.actions.state'
      local actions = require 'telescope.actions'

      local current_picker = action_state.get_current_picker(prompt_bufnr)
      local multi_selections = current_picker:get_multi_selection()

      if next(multi_selections) == nil then
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.api.nvim_buf_delete(selection.bufnr, { force = true })
      else
        actions.close(prompt_bufnr)
        for _, selection in ipairs(multi_selections) do
          vim.api.nvim_buf_delete(selection.bufnr, { force = true })
        end
      end
    end

    map('i', '<C-x>', delete_buf)
    return true
  end

  M.pickers.buffers(opts)
end

-- common opts users would like to have a default for
local pickers_defaults = { previewer = false, disable_devicons = true }

function M.pickers_wrapper(builtins)
  return setmetatable({}, {
    __index = function(_, key)
      if builtins[key] == nil then
        error 'Invalid key, please check :h telescope.builtin'
        return
      end
      return function(opts)
        opts = vim.tbl_extend('keep', opts or {}, pickers_defaults)
        builtins[key](opts)
      end
    end,
  })
end

M.pickers = M.pickers_wrapper(require 'telescope.builtin')

return M
