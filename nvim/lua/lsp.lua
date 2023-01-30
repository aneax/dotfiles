require("mason").setup()
local whichkey = require("which-key")
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = {
  noremap = true,
  silent = true
}
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<A-q>', vim.diagnostic.setloclist, opts)
vim.keymap.set("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
vim.keymap.set("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
vim.keymap.set({ "n", "v" }, "K", vim.lsp.buf.hover, { buffer = 0 })


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bskmp = vim.api.nvim_buf_set_keymap

  --bskmp(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --bskmp(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --bskmp(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  bskmp(bufnr, 'n', '<A-f>', '<cmd>lua vim.lsp.buf.format {async=true}<CR>', opts)

  -- for nvim-navic
  if client.server_capabilities.documentSymbolProvider then
    local navic = require("nvim-navic")
    navic.attach(client, bufnr)
  end


  require("lsp_configs.highlight").do_highlight(client)
  --[[ require "lsp_signature".on_attach({
    bind = true,
    handler_opts = {
      border = "rounded"
    }
  }, bufnr) ]]

  local keymap_g = {
    name = "Goto",
    d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
    D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
    s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
    r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
  }

  local keymap_l = {
    l = {
      name = "Code",
      r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
      D = { "<cmd>Telescope diagnostics<CR>", "Telescope Diagnostics" },
      d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },
      A = { "<cmd>Telescope lsp_code_actions()<CR>", "Telescope Action" },
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
      i = { "<cmd>LspInfo<CR>", "Lsp Info" },
      f = { "<cmd>Lspsaga lsp_finder<CR>", "Finder" },
      n = { "<cmd>Lspsaga rename<CR>", "Rename" },
      t = { "<cmd>TroubleToggle<CR>", "Trouble" },
      g = { "<cmd>Neogen func<cr>", "Function Documentation" },
      c = { "<cmd>Neogen class<cr>", "Class Documentation" }

    },
    e = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Line Diagnostics" },
  }

  if client.server_capabilities.document_formatting then
    keymap_l.l.f = { "<cmd>lua vim.lsp.buf.format(async=true)<CR>", "Format Document" }
  end

  whichkey.register(keymap_g, {
    buffer = bufnr,
    prefix = "g"
  })

  whichkey.register(keymap_l, { buffer = bufnr, prefix = "<leader>" })
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  clangd = {}, sumneko_lua = {}, cmake = {}, marksman = {}, pylsp = {}, rust_analyzer = {},
}
servers["sumneko_lua"] = {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
      },
    },
  },
} --

servers["clangd"] = {
  cmd = { "completion-style=bundled", "function-arg-placeholders=true", "malloc-trim", "-j 8",
    "background-index-priority=background" }
}

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

local lspconfig = require("lspconfig")
for server, _ in pairs(servers) do
  lspconfig[server].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150
    },
    capabilitites = capabilities,
  }
end

local lsp = {
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
  },
  diagnostic = {
    --virtual_text = {spacing = 4, prefix = ""},
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
    },
  },
  bind = true,
}

-- Diagnostic signs
local diagnostic_signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(diagnostic_signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

-- Diagnostic configuration
vim.diagnostic.config(lsp.diagnostic)
-- Hover configuration
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, lsp.float)
-- Signature help configuration
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, lsp.float)
-- ufo setup , folding
require('ufo').setup()
