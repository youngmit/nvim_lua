local o = vim.o
local bo = vim.bo
local wo = vim.wo

local home = os.getenv("HOME")
--- Language server config
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

local on_lsp_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_option(bufnr, 'foldexpr', "v:lua.vim.lsp.foldexpr()")

    local bufopts = { noremap=true, silent=true, buffer=bufnr}
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<Leader>gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', 'fm', vim.lsp.buf.format, bufopts)
    vim.keymap.set('n', 'J', vim.lsp.buf.completion, bufopts)
    vim.keymap.set('n', 'ff', vim.lsp.buf.format, bufopts)
    vim.keymap.set('n', '<leader>w', function()

    local params = vim.lsp.util.make_formatting_params({})
    local handler = function(err, result)
      if not result then return end

      vim.lsp.util.apply_text_edits(result, bufnr, client.offset_encoding)
      vim.cmd('write')
    end

    client.request('textDocument/formatting', params, handler, bufnr)
  end, {buffer = bufnr})
end

local lsp_flags = {
    debounce_text_changes = 150,
}

local in_brazil = vim.fn.executable("brazil-runtime-exec") == 1
    and vim.fn.findfile("Config", vim.fn.getcwd() .. ";") ~= ""

if in_brazil then
    vim.lsp.config("clangd", {
        cmd = {"brazil-runtime-exec", "x86_64-unknown-linux-gnu-clangd", "--background-index", "--query-driver=" .. home .. "/**/*-linux-*"},
        on_attach = on_lsp_attach,
        flags = lsp_flags,
        filetypes = {"c", "cc", "cpp", "objc", "objcpp", "cuda"},
        root_markers = {'Config'},
    })
else
    vim.lsp.config("clangd", {
        cmd = {"clangd", "--background-index"},
        on_attach = on_lsp_attach,
        flags = lsp_flags,
        filetypes = {"c", "cc", "cpp", "objc", "objcpp", "cuda"},
    })
end

vim.lsp.config("pyright", {
    cmd = {home .. "/.venvs/nvim/bin/pyright-langserver", "--stdio"},
    on_attach = on_lsp_attach,
    flags = lsp_flags,
})

vim.lsp.enable("pyright")
vim.lsp.enable("clangd")

