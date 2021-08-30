return require('packer').startup(function()
    use "savq/paq-nvim"

    use "tpope/vim-fugitive"
    use "kien/ctrlp.vim"
    use "scrooloose/nerdtree"
    use "vim-airline/vim-airline"
    use "vim-airline/vim-airline-themes"
    use "airblade/vim-gitgutter"
    use "tomtom/tcomment_vim"
    use "machakann/vim-highlightedyank"

    use {"sonph/onehalf", rtp="vim"}


end)
