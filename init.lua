local o = vim.o
local bo = vim.bo
local wo = vim.wo


wo.colorcolumn = "80"
wo.number = true
wo.relativenumber = true
wo.cursorline = true

o.mouse = "a"
o.expandtab = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.autoindent = true
o.textwidth = 80

o.hlsearch = true
o.tabstop = 4

vim.api.nvim_set_keymap("n", "<F2>", ":NERDTreeToggle<CR>", {noremap = true})


require('plugins')
