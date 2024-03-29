-- Set up nvim-cmp.
local cmp = require('cmp')
local luasnip = require('luasnip')
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  completion = {
    completeopt = "menu,menuone,noinsert",
    keyword_length = 1
  },
  experimental = {
    native_menu = false,
    ghost_test = false
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end
  },
  formatting = {
    format = function(entry, item)
      item.menu = ({
        buffer = "[Buffer]",
        luasnip = "[Snip]",
        nvim_lua = "[Lua]",
        treesitter = "[Treesitter]"
      })[entry.source_name]
      return item
    end
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<S-Cr>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {
      "i",
      "s",
      "c",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
      "c",
    }),
  }),
  sources = cmp.config.sources({ {
    name = 'nvim_lsp'
  }, {
    name = 'buffer'
  }, {
    name = 'luasnip'
  }, { name = 'nvim_lsp_signature_help' } }),
  -- documentation = {
  --     border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},
  --     winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder"
  -- }
})

-- -- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--     sources = cmp.config.sources({{
--         name = 'cmp_git'
--     } -- You can specify the `cmp_git` source if you were installed it.
--     }, {{
--         name = 'buffer'
--     }})
-- })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { {
    name = 'buffer'
  } }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ {
    name = 'path'
  } }, { {
    name = 'cmdline'
  } })
})
