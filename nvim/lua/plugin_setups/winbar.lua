-- Based on: https://github.com/alpha2phi/neovim-for-beginner/blob/42-winbar/lua/config/whichkey.lua

local colors = require('plugin_setups.colors')
local navic = require('nvim-navic')
local icons = require('plugin_setups.icons')
local M = {}
vim.api.nvim_set_hl(0, "WinBarSeparator", { fg = colors.grey })
vim.api.nvim_set_hl(0, "WinBarFilename", { fg = colors.green, bg = colors.grey })
vim.api.nvim_set_hl(0, "WinBarContext", { fg = colors.green, bg = colors.grey })

M.winbar_filetype_exclude = {
  "help",
  "startify",
  "dashboard",
  "packer",
  "neogitstatus",
  "NvimTree",
  "Trouble",
  "alpha",
  "lir",
  "Outline",
  "spectre_panel",
  "toggleterm",
}


local function is_empty(s)
  return s == nil or s == ""
end

local function get_buf_option(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not status_ok then
    return nil
  else
    return buf_option
  end
end

local excludes = function()
  if vim.tbl_contains(M.winbar_filetype_exclude, vim.bo.filetype) then
    vim.opt_local.winbar = nil
    return true
  end
  return false
end

local function get_modified()
  if get_buf_option "mod" then
    local mod = icons.git.Mod
    return "%#WinBarFilename#" .. mod .. " " .. "%t" .. "%*"
  end
  return "%#WinBarFilename#" .. "%t" .. "%*"
end

local function get_location()
  local location = navic.get_location()
  if not is_empty(location) then
    return "%#WinBarContext#" .. " " .. icons.ui.ChevronRight .. " " .. location .. "%*"
  end
  return ""
end

function M.get_winbar()
  if excludes() then
    return ""
  end
  if navic.is_available() then
    return "%#WinBarSeparator#"
        .. "%="
        .. ""
        .. "%*"
        .. get_modified()
        .. get_location()
        .. "%#WinBarSeparator#"
        .. ""
        .. "%*"
  else
    return "%#WinBarSeparator#" .. "%=" .. "" .. "%*" .. get_modified() .. "%#WinBarSeparator#" .. "" .. "%*"
  end
end

return M
