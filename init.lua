local o = vim.o
local bo = vim.bo
local wo = vim.wo

local home = os.getenv("HOME")

wo.colorcolumn = "88"
wo.number = true
wo.relativenumber = true
wo.cursorline = true
wo.foldmethod = "expr"
wo.foldexpr = "nvim_treesitter#foldexpr()"
wo.foldlevel = 99

o.mouse = "a"
o.expandtab = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.autoindent = true
o.textwidth = 88
o.hlsearch = true
o.grepprg = "git grep -n --column --recurse-submodules $*"
o.diffopt = "filler,vertical"

vim.g.python3_host_prog = "/home/mthyoung/.pyenv/versions/nvim/bin/python"

vim.g.airline_powerline_fonts = 1

vim.g.mapleader = ' '

vim.api.nvim_set_keymap("n", "<F2>", ":NvimTreeToggle<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<F8>", ":TagbarToggle<CR>", {noremap = true})

vim.api.nvim_set_keymap("n", "<Leader>fa", ":grep! \"\\b<C-R><C-W>\\b\"<CR>:copen<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>nn", ":cnext<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>nN", ":cprev<CR>", {noremap = true})

require("config.lazy")

vim.api.nvim_command('autocmd FileType qf wincmd J')
vim.api.nvim_command('autocmd FileType gitcommit setlocal spell')

-- vim.api.nvim_command('autocmd FileType c,cpp ClangFormatAutoEnable')
-- vim.api.nvim_command('autocmd BufWritePre *.py silent! execute \':Black\'')


require("config.lsp")
require("config.telescope")
