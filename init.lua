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

vim.cmd("au BufNewFile,BufRead *Jenkinsfile* setf groovy")

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


--- Language server config
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

local on_lsp_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap=true, silent=true, buffer=bufnr}
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.declaration, bufopts)
end

local lsp_flags = {
    debounce_text_changes = 150,
}

require'lspconfig'.clangd.setup{
    on_attach = on_lsp_attach,
    flags = lsp_flags,
    --- disable proto, because clangd suxxxxx at it
    filetypes = {"c", "cpp", "objc", "objcpp", "cuda"},
}
require'lspconfig'.pyright.setup{
    on_attach = on_lsp_attach,
    flags = lsp_flags,
}
