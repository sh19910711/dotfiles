TMPDIR=/tmp/vim
VERSION=8.0.1391

download() {
	local archive=v$VERSION.tar.gz
	if [[ ! -e $archive ]]; then
		wget https://github.com/vim/vim/archive/$archive
		tar zxvf v$VERSION.tar.gz
	fi
}

build() {
	pushd vim-$VERSION
	./configure
	make
	make install
	popd
}

mkdir -p $TMPDIR
cd $TMPDIR
download
build
