clone() {
  [[ ! -d $2 ]] && git clone $@
  pushd ~/.vim.d/bundle/nerdtree
  git pull origin master
  popd
}
