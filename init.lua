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
o.grepprg = "git grep -n --recurse-submodules $*"
o.diffopt = "filler,vertical"

vim.g.python3_host_prog = "~/.venvs/nvim/bin/python"

vim.g.airline_powerline_fonts = 1

vim.g.mapleader = ' '

vim.api.nvim_set_keymap("n", "<F2>", ":NERDTreeToggle<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<F8>", ":TagbarToggle<CR>", {noremap = true})

vim.api.nvim_set_keymap("n", "<Leader>fa", ":grep! \"\\b<C-R><C-W>\\b\"<CR>:copen<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>nn", ":cnext<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<Leader>nN", ":cprev<CR>", {noremap = true})

vim.cmd("au BufNewFile,BufRead *Jenkinsfile* setf groovy")

vim.fn.setenv("MYVIMPLUGINS", "~/.config/nvim/lua/plugins.lua")

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

vim.api.nvim_command('autocmd FileType c,cpp ClangFormatAutoEnable')
vim.api.nvim_command('autocmd BufWritePre *.py silent! execute \':Black\'')


--- Language server config
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

local on_lsp_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap=true, silent=true, buffer=bufnr}
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<Leader>gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', 'J', vim.lsp.buf.completion, bufopts)
end

local lsp_flags = {
    debounce_text_changes = 150,
}

require'lspconfig'.clangd.setup{
    cmd = {"clangd", "--background-index", "--compile-commands-dir=build"},
    on_attach = on_lsp_attach,
    flags = lsp_flags,
    --- disable proto, because clangd suxxxxx at it
    filetypes = {"c", "cpp", "objc", "objcpp", "cuda"},
}

require'lspconfig'.pyright.setup{
    cmd = {home .. "/.venvs/nvim/bin/pyright-langserver", "--stdio"},
    on_attach = on_lsp_attach,
    flags = lsp_flags,
}

require('telescope').setup{
    defaults = {
        path_display={"smart"}
    }
}

-- Telescope finder bindings
local ts_builtin = require('telescope.builtin')
vim.keymap.set("n", "<Leader>ff", ts_builtin.git_files, {noremap = true})
vim.keymap.set("n", "<Leader>fz", ts_builtin.spell_suggest, {noremap = true})
vim.keymap.set("n", "<Leader>fb", ts_builtin.buffers, {noremap = true})
vim.keymap.set("n", "<Leader>fj", ts_builtin.jumplist, {noremap = true})
vim.keymap.set("n", "<Leader>fr", ts_builtin.lsp_references, {noremap = true})
vim.keymap.set("n", "<leader>fr", ts_builtin.lsp_references, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fS", ts_builtin.lsp_workspace_symbols, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fs", ts_builtin.lsp_document_symbols, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fd", ts_builtin.lsp_definitions, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ft", ts_builtin.treesitter, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>c", require('osc52').copy_operator, {expr = true})
vim.keymap.set("v", "<leader>c", require('osc52').copy_visual)
