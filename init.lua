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

vim.g.python3_host_prog = os.getenv("HOME") .. "/.pyenv/versions/neovim/bin/python"

vim.g.airline_powerline_fonts = 1
vim.g.airline_section_y = '%{v:lua.vim.lsp.status()}'

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

-- Detect tab-indented files and disable expandtab for them
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, math.min(100, vim.api.nvim_buf_line_count(0)), false)
    local tabs, spaces = 0, 0
    for _, line in ipairs(lines) do
      if line:match("^\t") then tabs = tabs + 1
      elseif line:match("^    ") then spaces = spaces + 1
      end
    end
    if tabs > spaces then
      vim.bo.expandtab = false
      vim.bo.tabstop = 4
      vim.bo.softtabstop = 4
      vim.bo.shiftwidth = 4
    end
  end,
})