local o = vim.o
local bo = vim.bo
local wo = vim.wo


wo.colorcolumn = "80"
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
o.textwidth = 80
o.hlsearch = true
o.grepprg = "git grep -n --recurse-submodules $*"
o.diffopt = "filler,vertical"

vim.api.nvim_set_keymap("n", "<F2>", ":NERDTreeToggle<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<F8>", ":TagbarToggle<CR>", {noremap = true})

vim.api.nvim_set_keymap("n", "<Leader>fa", ":grep! \"\\b<C-R><C-W>\\b\"<CR>:copen<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>nn", ":cnext<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>nN", ":cprev<CR>", {noremap = true})

vim.cmd('au BufNewFile,BufRead *Jenkinsfile* setf groovy')

require('plugins')

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = false,
    },
}

require'treesitter-context'.setup{
    enable = true,
    throttle = true,
}

vim.api.nvim_command('autocmd FileType qf wincmd J')
