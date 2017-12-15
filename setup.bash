set -eu
source helper.bash 

clone https://github.com/scrooloose/nerdtree ~/.vim.d/bundle/nerdtree
cat <<EOF > ~/.vimrc
set nocompatible
"
syntax off
set number
set relativenumber
set colorcolumn=80
set hlsearch
"
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
" plugins
set runtimepath+=~/.vim.d/bundle/nerdtree
EOF
