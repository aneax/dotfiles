local gs = require("gitsigns")

gs.setup {
  word_diff = true,
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map("n", "<leader>hp", gs.preview_hunk, { desc = 'Preview Hunk' })
    map("n", "<leader>hB", function()
      gs.blame_line { full = true }
    end, { desc = "Full Blame Line" })
    map('n', '<leader>hd', gs.diffthis, { desc = "Diff" })
    map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Diff Change/Delete" })
    map('n', '<leader>hb', gs.toggle_current_line_blame, { desc = "Current Blame Line" })
  end,
}

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = "*",
  callback = function()
    vim.cmd [[
      hi GitSignsChangeInline gui=reverse
      hi GitSignsAddInline gui=reverse
      hi GitSignsDeleteInline gui=reverse
    ]]
  end
})
