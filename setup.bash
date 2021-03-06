set -eu

clone() {
  [[ ! -d $2 ]] && git clone $@
  pushd $2
  git pull origin master
  popd
}

### bash
mkdir -p ~/.bash.d
cat <<EOF | tee ~/.bashrc
for x in ~/.bash.d/*.bash; do
  source \$x
done
EOF

curl https://raw.githubusercontent.com/git/git/v2.14.5/contrib/completion/git-completion.bash > ~/.bash.d/git.bash

cat <<EOF | tee ~/.bash.d/bash.bash
PS1="[\u@\h \W]\$ "
EOF

cat <<EOF | tee ~/.bash.d/golang.bash
export GOPATH=\$HOME/go
EOF

cat <<EOF | tee ~/.bash.d/zeppelin.bash
zeppelin() {
  docker run \
    --name zeppelin \
    --rm \
    -ti \
    -p 8080:8080 \
    -v $HOME/.ssh:/root/.ssh \
    -e ZEPPELIN_NOTEBOOK_STORAGE=org.apache.zeppelin.notebook.repo.S3NotebookRepo \
    -e ZEPPELIN_NOTEBOOK_S3_BUCKET=cloud9-tmp \
    -e ZEPPELIN_NOTEBOOK_S3_USER=zeppelin/notebook \
    apache/zeppelin:0.7.3
}
EOF

### vim
clone https://github.com/scrooloose/nerdtree ~/.vim.d/bundle/nerdtree
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/c3b6b7c2971da730d66f6955d5c467db8dae536b/plug.vim
cat <<EOF | tee ~/.vimrc
" ui
syntax off
set number
set relativenumber
set colorcolumn=80
set hlsearch

" edit
set encoding=utf-8
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2

" make
autocmd BufRead,BufNewFile Makefile setfiletype make
autocmd FileType make set noexpandtab

" plugins
set runtimepath+=~/.vim.d/bundle/nerdtree

" nerdtree
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" lsp
call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
call plug#end()
setlocal omnifunc=lsp#complete
EOF

### git
git config --global core.editor 'vim'
git config --global user.name  'Hiroyuki Sano'
git config --global user.email 'sh19910711@gmail.com'

mkdir -p ~/.config/git
cat <<EOF | tee ~/.config/git/ignore
*.swp
tmp/
EOF

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
  IdentityFile ~/.ssh/id_github_sh19910711
EOF
chmod go-rwx ~/.ssh/config

### x11
cat <<EOF | tee ~/.xinitrc
export DefaultImModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
EOF

cat <<EOF | tee ~/.Xresources
urxvt*inputMethod: fcitx
urxvt*font: xft:Noto Sans Mono:size=10,\
  xft:Noto Sans Mono CJK JP:size=10,\
  xft:Noto Emoji:size=10,\
  xft:monospace:size=10
EOF

sudo() {
  if /usr/bin/sudo echo hello > /dev/null; then
    /usr/bin/sudo $@
  else
    $@
  fi
}

sudo mkdir -p /etc/X11/xorg.conf.d
cat <<EOF | sudo tee /etc/X11/xorg.conf.d/00-capslock.conf
Section "InputClass"
  Identifier "system-keyboard"
  MatchIsKeyboard "on"
  Option "XkbLayout" "us"
  Option "XkbOptions" "ctrl:swapcaps"
EndSection
EOF
