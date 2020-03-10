docker build -t vim ./
id=$(docker create vim)
docker wait $id
docker cp $id:/opt/vim/package.tar.gz - > ./package.tar.gz
docker rm -v $id
