-- Example:
-- vim.keymap.set('n', '<space>w', '<cmd>write<cr>', {desc = 'Save'})
--
-- space+w will call write command and save changes made to a file with space+w.
--
-- vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
--
-- {mode} where the keybinding should execute
-- 	n : normal
-- 	i : insert
-- 	x : visual
-- 	s : selection
-- 	t : terminal
-- 	v : visual + selection
-- 	o : operator-pending
-- 	'': n + v + o
-- {lhs} is the key we want to bind
-- {rhs} is the action to be executed
-- {opts} is a lua table and can have properties
-- 	desc : describes what binding does
-- 	remap: boolen that determines if the keybinding can be recursive. Recursive keybinding can cause conflicts if used incorrectly.
-- 	buffer: boolean or number. true means only effective in the current file. If number is assigned, it needs to be the 'id' of an open buffer.
-- 	silent: can keybindings show a message?
-- 	expr: boolean. If enables allows vimscript or lua to calculate value of {rhs}
--
local opts = {
  noremap = true,
  silent = true
}

local keymap = vim.keymap.set

-- Set space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- copy from clipboard
keymap({ 'n', 'x' }, 'cp', '"+y"')

-- paste from clipboard
keymap({ 'n', 'x' }, 'cv', '"+p"')

-- delete without changing the registers
keymap({ 'n', 'x' }, 'x', '"_x"')

---- Normal Mode ----
-- select all text in current buffer
keymap('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- open explorer
-- keymap("n", "<leader>e", ":Lex 30<CR>", opts)

-- resize with arrow
keymap('n', "<C-Up>", ":resize +2<CR>", opts)
keymap('n', "<C-Down>", ":resize -2<CR>", opts)
keymap('n', "<C-Left>", ":vertical resize +2<CR>", opts)
keymap('n', "<C-Right>", ":vertical resize -2<CR>", opts)

-- navigate buffers
keymap("n", "<S-Right>", ":bnext<cr>", opts)
keymap("n", "<S-Left>", ":bprevious<cr>", opts)

-- better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

---- Insert mode ------

-- fast escape insert mode
keymap("i", "jk", "<Esc>", opts)
keymap("t", "jk", "<C-\\><C-n>", opts)
---- Visual mode ----

-- better indent
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Paste over currently selected text without yanking it.
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
