FROM debian:9.12

RUN apt update && apt install -y curl
RUN apt install -y make
RUN apt install -y build-essential
RUN apt install -y libncurses5-dev

ENV VIM_VERSION=8.2.0369
RUN mkdir -p /opt/vim
WORKDIR /opt/vim
RUN curl -s -L https://github.com/vim/vim/archive/v$VIM_VERSION.tar.gz | tar zxf -
RUN cd vim-$VIM_VERSION && \
  ./configure \
    --prefix=/usr/local && \
  make && \
  make install DESTDIR=/opt/vim/pkg
RUN cd /opt/vim/pkg && tar zcvf ../package.tar.gz ./
