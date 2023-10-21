return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use "tpope/vim-fugitive"
    -- disabled in favor of telescope
    -- use "kien/ctrlp.vim"
    use "scrooloose/nerdtree"
    use "vim-airline/vim-airline"
    use "vim-airline/vim-airline-themes"
    use "airblade/vim-gitgutter"
    use "tomtom/tcomment_vim"
    use "machakann/vim-highlightedyank"
    use "ntpeters/vim-better-whitespace"
    use "johnfrankmorgan/whitespace.nvim"
    use "preservim/tagbar"
    use "Glench/Vim-Jinja2-Syntax"

    -- copying over SSH
    use "ojroques/nvim-osc52"

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
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

    use 'puremourning/vimspector'
    use 'sakhnik/nvim-gdb'
    use 'neovim/nvim-lspconfig'
    use 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'

    use({
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        module = "persistence",
        config = function()
          require("persistence").setup()
        end,
    })

    use {
        'kevinhwang91/nvim-ufo',
        requires = 'kevinhwang91/promise-async',
    }

    local capabs = vim.lsp.protocol.make_client_capabilities()
    capabs.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }

    local language_servers = require("lspconfig").util.available_servers()
    for _, ls in ipairs(language_servers) do
        require("lspconfig")[ls].setup({capabilities = capabs})
    end

    require('ufo').setup()

end)
