
local vo = vim.opt

vo.list=true
vo.listchars:append("space:⋅")

require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    filetype_exclude = { "help", "packer" },
    buftype_exclude = { "terminal", "nofile" },
    show_trailing_blankline_indent = false,
  }
