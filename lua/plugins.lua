return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use "tpope/vim-fugitive"
    use "kien/ctrlp.vim"
    use "scrooloose/nerdtree"
    use "vim-airline/vim-airline"
    use "vim-airline/vim-airline-themes"
    use "airblade/vim-gitgutter"
    use "tomtom/tcomment_vim"
    use "machakann/vim-highlightedyank"
    use "ntpeters/vim-better-whitespace"
    use "preservim/tagbar"
    use "Glench/Vim-Jinja2-Syntax"

    use "rhysd/vim-clang-format"
    use {
        "psf/black",
        branch = "stable",
    }

    use {
        "sonph/onehalf",
        rtp="vim",
        config = function() vim.cmd("colorscheme onehalfdark") end,
    }

    use 'nvim-treesitter/nvim-treesitter'
    -- Like context.vim, displays class/function/block context
    -- at the top of the screen while scrolling through code.
    use 'romgrk/nvim-treesitter-context'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use 'puremourning/vimspector'
    use 'sakhnik/nvim-gdb'
    use 'neovim/nvim-lspconfig'
end)
