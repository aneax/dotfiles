local vo = vim.opt

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- show line numbers
vo.number = true

-- enable relative numbering
vo.relativenumber = true

-- enable mouse for every modes
vo.mouse = 'a'

-- ignore cases when searching
vo.ignorecase = false

-- makes search ignore uppercase letters unless the search term has an uppercase letter. 
vo.smartcase = true

-- highlights the results of previous search
vo.hlsearch = true

-- wrap long lines
vo.wrap = true

-- preserve indentation of virtual line (when wrap is enabled)
vo.breakindent = true

-- tab space 
vo.tabstop = 2

-- show tab line
vo.showtabline = 2

-- shiftwidth (characters used to indent a line)
vo.shiftwidth = 2

-- transform tab to space
vo.expandtab = true

--
vo.cmdheight = 2

-- file encoding
vo.fileencoding = "utf-8"

-- put new window below the current one
vo.splitbelow = true

-- put new window right of the current one
vo.splitright = true

-- characters to fill the statuslines and vertical separators
vo.fillchars = {
		horiz = "━",
		horizup="┻",
		horizdown="┳",
		vert = "┃",
		vertleft = "┫",
		vertright = "┣",
		verthoriz = "╋",
}

-- enable 24-bit RGB color in the TUI
vo.termguicolors = true

-- time in milliseconds to wait fro a mapped sequence to complete
vo.timeoutlen = 800

-- auto saving (if nothing is typed for this many milliseconds)
vo.updatetime = 300

-- minimal number of screen lines to keep above and below the cursor
vo.scrolloff = 5

-- minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set
vo.sidescrolloff = 8

-- see difference between tabs, space, trailing blanks, ...
-- Defaults:
-- 		tabs: '>' 
-- 		trailing spaces: '-'
-- 		non-breakable space characters: '+'
vo.list = true

vo.listchars = {
	tab = "»·",
	extends = "↪",
	precedes = "↩",
	eol="↵"
}

-- set background
vo.background = "dark"

-- allows nvim to access the system clipboard
vo.clipboard = "unnamedplus"

-- for cmp
vo.completeopt = { "menuone", "noselect" }

-- pop up menu height
vo.pumheight = 10

-- don't show modes
vo.showmode = false

-- highlight current line
vo.cursorline = true

--
vo.signcolumn = "yes"

-- Remember 50 items in commandline history
vo.history = 50

-- Folding setting 
vo.foldcolumn = "1"
vo.foldlevel = 99
vo.foldenable = true
vo.foldlevelstart = 99
