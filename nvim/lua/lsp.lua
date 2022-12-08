

require("mason").setup()

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bskmp = vim.api.nvim_buf_set_keymap

  bskmp(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  bskmp(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  bskmp(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  bskmp(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  bskmp(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  bskmp(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  bskmp(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  bskmp(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  bskmp(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  bskmp(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  bskmp(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  bskmp(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  bskmp(bufnr, 'n', '<A-f>', '<cmd>lua vim.lsp.buf.format(async = true )<CR>', opts)

  -- for nvim-navic
  if client.server_capabilities.documentSymbolProvider then
    local navic = require("nvim-navic")
      navic.attach(client, bufnr)
  end

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd', 'sumneko_lua', 'cmake' }

-- Set up lspconfig.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- capabilities.textDocument.foldingRange = {
--  dynamicRegistration = false,
--  lineFoldingOnly = true
-- }
local lspconfig = require("lspconfig")
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
    -- capabilitites = capabilities
  }
end

-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup(
--   require('coq').lsp_ensure_capabilities({
--     on_attach = on_attach,
--   })
--   )
-- end

-- ufo setup , folding
require('ufo').setup()
