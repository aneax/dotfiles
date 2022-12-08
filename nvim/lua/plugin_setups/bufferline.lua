vim.opt.termguicolors = true
require("bufferline").setup {
  options = {
    mode = "buffers",
    numbers = "buffer_id",
    buffer_close_icon = '',
    diagnostics = "nvim_lsp",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "left",
      },
    },
    separator_style = "slant" or "padded_slant",
    --        enforce_regular_tabs = true,
  },
}
