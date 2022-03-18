cat config_base.yaml config_gh.yaml > config.yaml
docker run --rm -it \
  --name lh_hugo \
  -v $(pwd):/src \
  -p 1313:1313 \
  klakegg/hugo \
  server
