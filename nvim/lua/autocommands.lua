local api = vim.api


-- Highlight on yank
local yankGroup = api.nvim_create_augroup("YankHighlight", { clear = true })

api.nvim_create_autocmd("TextYankPost", { commad = "silent! lua vim.highlight.on_yank()", group = yankGroup })


--  
