.PHONY:
build:
	docker build -t vim ./
	echo $(shell \
		id=$$(docker create vim) && \
		docker cp $$id:/opt/vim/package.tar.gz - > ./package.tar.gz && \
		docker rm -v $$id )
