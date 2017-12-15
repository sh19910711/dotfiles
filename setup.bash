set -eu
source helper.bash 

clone https://github.com/scrooloose/nerdtree ~/.vim.d/bundle/nerdtree
cat <<EOF > ~/.vimrc
" ui
syntax off
set number
set relativenumber
set colorcolumn=80
set hlsearch

" edit
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2

" make
autocmd BufRead,BufNewFile Makefile setfiletype make
autocmd FileType make set noexpandtab

" plugins
set runtimepath+=~/.vim.d/bundle/nerdtree
EOF
