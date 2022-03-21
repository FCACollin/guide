pandoc -i citations.md_in                 \
  -f markdown  \
  --bibliography ref/ref.bib \
  --filter pandoc-citeproc                \
  -t markdown_strict+yaml_metadata_block  \
  --title-prefix                          \
  --standalone                            \
  --listings                              \
  -o citations.md
