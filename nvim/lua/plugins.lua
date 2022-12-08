-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('PACKER', {
    clear = true
  }),
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerCompile'
})

-- Automatically install and set up packer on any machine the configuration is added to.
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd('packadd packer.nvim')
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local conf = {
  profile = {
    enable = true,
    threshold = 2 -- amount in ms that a plugin load time must be over for it to be included in the profile
  },
  display = {
    open_fn = function()
      return require("packer.util").float {
        border = "rounded"
      }
    end
  }
}

-- Plugins
return require('packer').startup(function()
  -- packer can manage itself (Package Manager)
  use('wbthomason/packer.nvim')

  -- useful plugin
  use('nvim-lua/plenary.nvim')
  --   use('nvim-lua/popup.nvim')
  --
  -- colorscheme

  --  use({'gruvbox-community/gruvbox',
  --    config = set_colorscheme("gruvbox"),
  --   disable = true,
  --   })
  -- --
  use({
    "sainnhe/everforest",
    disable = true,
    config = function()
      vim.cmd("colorscheme everforest")
    end
  })

  use({
    'folke/tokyonight.nvim',
    -- config = set_colorscheme("tokyonight"),
    config = function()
      vim.cmd("colorscheme tokyonight")
    end,
    disable = false
  })
  -- Treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({
        with_sync = true
      })
      ts_update()
    end,
    requires = { 'p00f/nvim-ts-rainbow' }
  })
  --   Automatically close brackets
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end
  })

  -- Which key
  use({ "folke/which-key.nvim" })
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
  --   -- use({{
  --   --     'nvim-telescope/telescope.nvim',
  --   --     module = 'telescope',
  --   --     cmd = 'Telescope',
  --   --     config = function()
  --   --         require('plugins.telescope').telescope()
  --   --     end,
  --   --     requires = 'nvim-lua/plenary.nvim'
  --   -- }, {
  --   --     'nvim-telescope/telescope-fzf-native.nvim',
  --   --     opt = true,
  --   --     run = 'make'
  --   -- }, {
  --   --     'nvim-telescope/telescope-project.nvim',
  --   --     after = 'telescope.nvim'
  --   -- }, {
  --   --     'nvim-telescope/telescope-file-browser.nvim',
  --   --     module_pattern = '.*.extensions.file_browser.*'
  --   -- }, {
  --   --     'nvim-telescope/telescope-z.nvim',
  --   --     config = function()
  --   --         require('telescope').load_extension('z')
  --   --     end
  --   -- }})
  --
  -- cmp plugins
  --[[
    use({
        "ms-jpq/coq_nvim",
         branch = "coq",
         opt = true,
        run = ":COQdeps",
        requires = {{
            "ms-jpq/coq.artifacts",
            branch = "artifacts"
        }, {
           "ms-jpq/coq.thirdparty",
            branch = "3p",
            module = "coq_3p"
        }},
        disable = false
    })
  ]] --
  use({
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-buffer', -- buffer completions
      'hrsh7th/cmp-path', -- path completions
      'hrsh7th/cmp-cmdline', -- cmdline completions
      'saadparwaiz1/cmp_luasnip', -- snippet completions
      'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-nvim-lua', {
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
      { "ray-x/lsp_signature.nvim" },
      "folke/lua-dev.nvim",
      "RRethy/vim-illuminate",
    }
  })
  -- lsp based folding
  use {
    'kevinhwang91/nvim-ufo',
    requires = 'kevinhwang91/promise-async'
  }
  --   -- cmake integration
  --   use({ 'Civitasv/cmake-tools.nvim', requires = { 'mfussenegger/nvim-dap' } })
  --   -- debugging
  --   use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
  -- comments
  -- use({
  --     'numToStr/Comment.nvim',
  --     config = function()
  --         require("Comment").setup()
  --     end
  -- })
  -- context aware comments
  --   use({"JoosepAlviste/nvim-ts-context-commentstring"})
  --
  --   --
  -- trouble.nvim
  use {
    "folke/trouble.nvim",
    event = "BufReadPre",
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
  --   use ({
  --     "danymat/neogen",
  --     config = function()
  --         require('neogen').setup {}
  --     end,
  --     requires = "nvim-treesitter/nvim-treesitter",
  --     -- Uncomment next line if you want to follow only stable versions
  --     -- tag = "*"
  -- })

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

  -- Easy motion
  use {
    "ggandor/lightspeed.nvim",
    keys = { "s", "S", "f", "F", "t", "T" },
    config = function()
      require("lightspeed").setup {}
    end
  }

  -- Markdown
  use {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" }
  }

  -- Automatically setup configuration.
  -- This must be at the end of all plugins.
  if packer_bootstrap then
    require("packer").sync()
  end
end)
