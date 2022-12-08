

local nvim_tree = require('nvim-tree')
local tree_cb = require'nvim-tree.config'.nvim_tree_callback

vim.keymap.set('n', '<C-b>', '<Cmd>NvimTreeToggle<CR>', { silent = true })

require("nvim-tree").setup({
  open_on_setup = true,
  open_on_tab = true,
--  auto_close = true 
--  adaptive_size = true,
    update_focused_file = { enable = true },
  hijack_cursor = true,
  view = {
    adaptive_size = true,
    mappings = {
      -- list = {
        -- { key = { 'l', '<CR>', '<2-LeftMouse>' }, cb = tree_cb('edit') },
        -- { key = 'L', cb = tree_cb('cd') },
        -- { key = '<C-s>', cb = tree_cb('split') },
        -- { key = '<C-v>', cb = tree_cb('vsplit') },
        -- { key = '<C-t>', cb = tree_cb('tabnew') },
        -- { key = 'h', cb = tree_cb('close_node') },
        -- { key = 'i', cb = tree_cb('preview') },
        -- { key = 'R', cb = tree_cb('refresh') },
        -- { key = 'c', cb = tree_cb('create') },
        -- { key = 'D', cb = tree_cb('remove') },
        -- { key = 'r', cb = tree_cb('rename') },
        -- { key = 'd', cb = tree_cb('cut') },
        -- { key = 'y', cb = tree_cb('copy') },
        -- { key = 'p', cb = tree_cb('paste') },
        -- { key = 'gyn', cb = tree_cb('copy_name') },
        -- { key = 'gyp', cb = tree_cb('copy_path') },
        -- {
        --   key = 'gya',
        --   cb = tree_cb('copy_absolute_path'),
        -- },
        -- { key = 'H', cb = tree_cb('dir_up') },
        -- { key = 's', cb = tree_cb('system_open') },
        -- { key = 'q', cb = tree_cb('close') },
      -- }
    }
  }
})
