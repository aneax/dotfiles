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
local function plugins(use)
  -- packer can manage itself (Package Manager)
  use('wbthomason/packer.nvim')

  -- NVIM plugin load performance improvements
  use("lewis6991/impatient.nvim")

  use(require("plugin_setups.whichkey"))
  use(require("plugin_setups.comment"))
  if not vim.g.vscode then
    local m = require('plugin_setups.nvim_plugins')
    m.init(use)
    use(require("plugin_setups.treesitter"))
    require("plugin_setups")
    require("lsp")
    require("completion")
  end

  -- Automatically setup configuration.
  -- This must be at the end of all plugins.
  if packer_bootstrap then
    require("packer").sync()
  end
end

local packer = require("packer")

-- Performance
pcall(require, "impatient")

packer.init(conf)
packer.startup(plugins)
