M = {}
function M.init(use)

  -- useful plugin
  use('nvim-lua/plenary.nvim')

  -- colorscheme
  use({
    "sainnhe/everforest",
    disable = true,
    config = function()
      vim.cmd("colorscheme everforest")
    end
  })

  use({
    "rebelot/kanagawa.nvim",
    config = function()
      vim.cmd("colorscheme kanagawa")
    end
  })

  use({
    'folke/tokyonight.nvim',
    -- config = set_colorscheme("tokyonight"),
    config = function()
      vim.cmd("colorscheme tokyonight-moon")
    end,
    disable = true
  })

  --   Automatically close brackets
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end
  })

  -- For status bar
  use {
    'nvim-lualine/lualine.nvim',
    -- event = "VimEnter",
    config = function()
      require("plugin_setups.lualine")
    end,
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true
    }
  }

  --   -- for buffer lines
  use {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons'
  }

  -- nim-tree
  use({
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  })

  -- Telescope
  use({
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  })

  use({
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-buffer', -- buffer completions
      'hrsh7th/cmp-path', -- path completions
      'hrsh7th/cmp-cmdline', -- cmdline completions
      'saadparwaiz1/cmp_luasnip', -- snippet completions
      'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help', {
        'L3MON4D3/LuaSnip',
        config = function()
          require("plugin_setups.lua_snip")
        end
      }, "rafamadriz/friendly-snippets" }
  }) -- The completion plugin
  --
  -- Configurations for Nvim LSP
  use({
    'neovim/nvim-lspconfig',
    requires = { { -- Scope Information
      "SmiteshP/nvim-navic" }, { -- lsp manager
      "williamboman/mason.nvim" },
      -- Show function signature during typing
      --{ "ray-x/lsp_signature.nvim" },
      "folke/lua-dev.nvim",
      "RRethy/vim-illuminate",
      -- "jose-elias-alvarez/null-ls.nvim",
      {
        "j-hui/fidget.nvim",
        config = function()
          require("fidget").setup {}
        end,
      },
    }
  })

  use({ 'simrat39/rust-tools.nvim' })

  -- lsp based folding
  --
  use({
    'kevinhwang91/nvim-ufo',
    requires = { 'kevinhwang91/promise-async' }
  })
  -- cmake integration
  use({ 'Civitasv/cmake-tools.nvim', requires = { 'mfussenegger/nvim-dap' } })
  -- debugging
  use({ "rcarriga/nvim-dap",
    wants = { "nvim-dap-ui" },
    requires = { "mfussenegger/nvim-dap-ui", "nvim-telescope/telescope-dap.nvim", "theHamsta/nvim-dap-virtual-text", } })
  --context aware comments
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })

  --
  -- trouble.nvim
  use {
    "folke/trouble.nvim",
    --event = "BufReadPre",
    wants = "nvim-web-devicons",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("trouble").setup {
        use_diagnostic_signs = true,
      }
    end,
  }

  -- lspsaga.nvim
  use {
    "tami5/lspsaga.nvim",
    event = "VimEnter",
    cmd = { "Lspsaga" },
    config = function()
      require("lspsaga").setup {}
    end,
  }
  --   -- for doxygen
  use({
    "danymat/neogen",
    requires = "nvim-treesitter/nvim-treesitter",
    -- Uncomment next line if you want to follow only stable versions
    -- tag = "*"
  })

  -- Neogit, lazy load using command  "Neogit"
  use({
    "TimUntersberger/neogit",
    cmd = "Neogit",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("neogit").setup()
    end
  })

  -- Better Indentation
  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("plugin_setups.indent")
    end
  })

  -- Markdown
  use {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" }
  }

  -- Git command inside vim
  -- use { "tpope/vim-fugitive", event = "User InGitRepo" }

  use { "lewis6991/gitsigns.nvim", config = [[require('plugin_setups.git')]] }

  -- Better git commit experience
  -- use { "rhysd/committia.vim", opt = true, setup = [[vim.cmd('packadd committia.vim')]] }
end

return M
