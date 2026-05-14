require('telescope').setup{
    defaults = {
        path_display={"smart"}
    }
}

-- Telescope finder bindings
local ts_builtin = require('telescope.builtin')
vim.keymap.set("n", "<Leader>lf", ts_builtin.git_files, {noremap = true})
vim.keymap.set("n", "<Leader>fz", ts_builtin.spell_suggest, {noremap = true})
vim.keymap.set("n", "<Leader>fb", ts_builtin.buffers, {noremap = true})
vim.keymap.set("n", "<Leader>fj", ts_builtin.jumplist, {noremap = true})
vim.keymap.set("n", "<Leader>fr", ts_builtin.lsp_references, {noremap = true})
vim.keymap.set("n", "<leader>fr", ts_builtin.lsp_references, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fS", ts_builtin.lsp_workspace_symbols, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fs", ts_builtin.lsp_document_symbols, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fd", ts_builtin.lsp_definitions, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>fe", ts_builtin.diagnostics, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ft", ts_builtin.treesitter, { noremap = true, silent = true })

