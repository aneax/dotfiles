return {
  'nvim-treesitter/nvim-treesitter',
  run = function()
    local ts_update = require('nvim-treesitter.install').update({
      with_sync = true
    })
    ts_update()
  end,
  requires = { 'p00f/nvim-ts-rainbow' },
  config = function()
    require('nvim-treesitter.configs').setup {
      -- A list of parser names, or "all"

      -- ensure_installed = "all",
      ensure_installed = { "c", "lua", "bash" },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      -- List of parsers to ignore installing (for "all")
      ignore_install = { "javascript", "git" },

      highlight = {
        -- `false` will disable the whole extension
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
      },
      -- context_commentstring = {
      --   enable = true
      -- }
    }
  end,
}
