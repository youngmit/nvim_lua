return {
    { "tpope/vim-fugitive" },
    { "scrooloose/nerdtree" },

    { "vim-airline/vim-airline" },
    { "vim-airline/vim-airline-themes" },
    { "airblade/vim-gitgutter" },
    { "ojroques/nvim-osc52" },
    { "machakann/vim-highlightedyank" },
    { "preservim/tagbar" },
    { 
        "sonph/onehalf",
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. "/vim")
            vim.cmd("colorscheme onehalfdark")
        end,
    },
    -- Analysis/Navigation
    { "nvim-treesitter/nvim-treesitter" },
    { "romgrk/nvim-treesitter-context" },
    { "neovim/nvim-lspconfig" },
    { 
        "nvim-telescope/telescope.nvim",
        dependencies = {"nvim-lua/plenary.nvim"}
    },
    { 
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    },

    -- Python
    { "psf/black", branch = "stable" },
    { "Glench/Vim-Jinja2-Syntax" },
    -- C/C++
    -- { "" },
}
