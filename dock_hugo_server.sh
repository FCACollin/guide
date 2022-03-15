docker run --rm -it \
  --name lh_hugo \
  -v $(pwd):/src \
  -p 1313:1313 \
  klakegg/hugo \
  server
