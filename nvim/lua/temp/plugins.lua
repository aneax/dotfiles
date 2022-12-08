
-- root dir to install all plugins
vim.g.plugin_home = vim.fn.stdpath("data") .. "/site/pack/packer"

-- where to install 

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print('Installing packer...')
  local packer_url = 'https://github.com/wbthomason/packer.nvim'
  vim.fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
  print('Done.')

  vim.cmd('packadd packer.nvim')
  install_plugins = true
end


-- Reload neovim whenever plugins.lua is updated
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSyncc
	augroup end
]])

local ok, packer = pcall(require, "packer")
if not ok then
	print("packer.nvim is not installed. No plugins will get installed")
	return 
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({border = "rounded"})
		end,
	},
})

-- download packages
-- this just adds the package but not trigger install
require('packer').startup(function(use)
	-- Package manager
	use({ "wbthomason/packer.nvim", opt = true })
	
	-- libraries
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")
	
	-- speed up startup time by caching
	use("lewis6991/impatient.nvim")

	-- Theme inspired by atom
	use({ "navarasu/onedark.nvim", opt = true })
	use("Shatur/neovim-ayu")
  -- Treesitter
  use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
  })
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("ray-x/cmp-treesitter")
    -- Searching
    use("junegunn/fzf")
    use("junegunn/fzf.vim")

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    })
    use("nvim-telescope/telescope-file-browser.nvim")
    use("benfowler/telescope-luasnip.nvim")
    use("nvim-telescope/telescope-symbols.nvim")
    use("nvim-telescope/telescope-packer.nvim")
    use({
        "AckslD/nvim-neoclip.lua",
        requires = {
          {"kkharji/sqlite.lua", module = "sqlite" },
          {'nvim-telescope/telescope.nvim'},
        },
    })

		-- tmux
		use("tmux-plugins/vim-tmux")

  -- Movement
    use("ggandor/lightspeed.nvim")

    -- LSP, Snippets, Completions
    use("hrsh7th/nvim-cmp") -- The completion plugin
    use("hrsh7th/cmp-nvim-lsp") -- Lsp completion
    use("hrsh7th/cmp-nvim-lua") -- Neovim lua runtime API completion
    use("hrsh7th/cmp-buffer") -- buffer completions
    use("hrsh7th/cmp-path") -- path completions
    use("hrsh7th/cmp-cmdline") -- cmdline completions
    use("L3MON4D3/LuaSnip") --snippet engine
    use("saadparwaiz1/cmp_luasnip") -- snippet completions
    use("onsails/lspkind-nvim") -- pictograms for lsp completion items

    use({
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    })
    use("j-hui/fidget.nvim") -- LSP status endpoint handler
    use("weilbith/nvim-code-action-menu") -- Show code actions in a useful manner
    use("kosayoda/nvim-lightbulb") -- Show code actions in a useful manner
    use("folke/lua-dev.nvim")
    use("ray-x/lsp_signature.nvim")
	
		use("Shatur/neovim-ayu")
	if install_plugins then
		require('packer').sync()
	end
end)


-- if no need to install plugins return (early exit)
if install_plugins then 
	return 
end

