set -eu
source helper.bash 

### Vim
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

### Git
git config --global user.name  'Hiroyuki Sano'
git config --global user.email 'sh19910711@gmail.com'

### tmux
cat <<EOF > ~/.tmux.conf
set -g prefix C-a
unbind C-b
setw -g mode-keys vi
EOF
