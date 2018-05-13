set -eu
source $(cd $(dirname $0); pwd)/helper.bash

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
git config --global core.editor 'vim'
git config --global user.name  'Hiroyuki Sano'
git config --global user.email 'sh19910711@gmail.com'

### tmux
cat <<EOF > ~/.tmux.conf
set -g prefix C-a
unbind C-b
setw -g mode-keys vi
EOF

### ssh
mkdir -p ~/.ssh
cat <<EOF > ~/.ssh/config
Host github.com
  User git
  IdentityFile ~/.ssh/id_github
EOF
chmod go-rwx ~/.ssh/config

### x11
cat <<EOF > ~/.xinitrc
export DefaultImModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
EOF

cat <<EOF > ~/.Xdefaults
urxvt*inputMethod: fcitx
urxvt*font: xft:Noto Mono:size=10,\
  xft:Noto Emoji:size=10,\
  xft:Noto Sans CJK JP:size=10,\
  xft:monospace:size=10
EOF
