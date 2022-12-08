local opt = vim.opt
opt.winbar = "%{%v:lua.require('plugin_setups.winbar').get_winbar()%}"
