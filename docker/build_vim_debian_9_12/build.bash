docker build -t vim ./
id=$(docker create vim)
docker wait $id
docker cp $id:/opt/vim/package.tar.gz - | tar xvf - > ./package.tar.gz
docker rm -v $id
