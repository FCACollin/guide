# Deploy guide on localhost
# Based on
# <https://www.katacoda.com/courses/docker/create-nginx-static-web-server>

docker container stop serve_hugo_guide_container
docker rm serve_hugo_guide_container
docker image rm serve_hugo_guide

docker run --rm -it \
  -v $(pwd):/src \
  klakegg/hugo:0.92.1

docker build -t serve_hugo_guide .
docker run \
  --name serve_hugo_guide_container \
  --restart always \
  --detach \
  --publish 802:80 \
  serve_hugo_guide
