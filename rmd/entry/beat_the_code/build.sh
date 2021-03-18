# ============================================================================ #
# Title:  Bash file for Linux
# Author: FCA Collin
# Date:   191106
# ============================================================================ #

# Variables -------------------------------------------------------------------

SRC=btc_01
DEST=output
DESTPDF=$DEST/report/$SRC.pdf
DESTHGO=$DEST/hugo/$SRC.md


# #  R: From Rmd to md ----------------------------------------------------------
Rscript -e                               \
"
# ========= R script =================== #
# Convert the \"$SRC.Rmd\" to \"SRC\".md #
# [FC 191107 08:58]                      #
# For help about function:               #
# Rscript -e ?rmarkdown::render()        #
# ====================================== #

rmarkdown::render(
  \"$SRC.Rmd\",
  output_format = 'md_document',
    output_options = list(     
      preserve_yaml  = TRUE,     
      variant        = 'markdown' 
  )                         
);

0; # return 0 when worked until the end.

# ========= END R script =============== #
"


# Pandoc: from md to pdf -----------------------------------------------
pandoc $SRC.md                            \
  --filter pandoc-citeproc                \
  --pdf-engine=xelatex                    \
	--toc                                   \
  --listings                              \
  --default-image-extension=pdf           \
 	--variable=titlepage:true               \
  --variable=colorlinks:true              \
 	-o $DESTPDF


# Pandoc: from md to md ------------------------------------------------------
pandoc -i $SRC.md                         \
  --filter pandoc-citeproc                \
 	--default-image-extension=png           \
  -t markdown_strict+yaml_metadata_block  \
  --title-prefix                          \
  --standalone                            \
  --listings                              \
  -o $DESTHGO

cp -r img output/hugo/ 
rm -r ../../../hugo/content/r_content/$SRC
cp -r output/hugo ../../../hugo/content/r_content/$SRC

# Clear -----------------------------------------------------------------------
rm $SRC.md

