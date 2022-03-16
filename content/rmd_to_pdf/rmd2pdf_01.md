---
title: "Intro"
date: 2022-03-15T09:22:43+01:00

---


RStudio:

- File > New File > RMarkdown ... > Select output PDF and OK.
- See `rmd2pdf_01_01.Rmd`
{{<mermaid align="left">}}
sequenceDiagram
    participant Rmd
    participant pdf
    Rmd->>pdf: knit button
    Rmd->>pdf: = `rmarkdown::pdf_document()`
{{< /mermaid >}}

## rmarkdown: `render()`/`pdf_document()`

Under the hood, the rendering of a document is managed by R, but also involves
Pandoc. The `rmarkdown`'s functions `render()` and `pdf_document()` are high
level functions which can manages most of the features a user my need when
generating a document. 


{{<mermaid align="left">}}
sequenceDiagram
    participant Rmd
    participant md
    participant pdf
    Rmd->>md: R
    md->>pdf: pandoc
    Rmd->>pdf: rmarkdown::pdf_document()
    Note right of Rmd: keep_md=FALSE</br>toc=TRUE
{{< /mermaid >}}

- The options above can be passed via the `yaml` frontmatter
  (e.g. `rmd2pdf_01_03.Rmd`):
  ```yaml
  ---
  title: "Rmd to PDF"
  output:
    pdf_document:
      keep_md: true
      toc: true
  ---
  ```

- or via an output function.
  ```r
  render(
    input = "rmd2pdf_01_02.Rmd",
    output_format = pdf_document(toc = TRUE, keep_md = TRUE)
  )
  ```

{{% notice tip %}}
`render` and `pdf_document` are functions exported by the `rmarkdown` package.
Check
[`?rmarkdown::pdf_document` 's help](
https://rdrr.io/cran/rmarkdown/src/R/pdf_document.R).
{{% /notice %}}

## Pass arguments to pandoc

Some options are handled by pandoc and so called, these arguments must then
been conveyed to Pandoc which treats them as
 _[variables for LaTeX](https://pandoc.org/MANUAL.html#variables-for-latex)_.

{{<mermaid align="left">}}
sequenceDiagram
    participant Rmd
    participant md
    participant pdf
    Rmd->>+md: rmarkdown::pdf_document()
    Note right of Rmd: keep_md=FALSE</br>toc=TRUE
    md-->>-pdf: Pandoc
    Note right of md: Variables For LaTeX</br>fontfamily: libertinus-type1
{{< /mermaid >}}


The Pandoc variables for LaTeX can be provisionned by:

- the Rmarkdown document 
  [yaml front matter](
  https://bookdown.org/yihui/rmarkdown-cookbook/latex-variables.html#latex-variables
  ):
  ```yaml
  ---
  title: "Rmd to PDF"
  output:
    pdf_document:
      keep_md: true
      toc: true
  fontfamily: libertinus-type1
  ---
  ```
- the `pdf_document()` function:
```r
rmarkdown::render(
  input = "rmd2pdf_01_03.Rmd",
  output_format = rmarkdown::pdf_document(
    toc = TRUE,
    pandoc_args = list(
      "--variable=fontfamily:libertinus-type1"
    )
  )
)
```


## Pass arguments to the LaTeX engine

Pandoc itself is a high level programs which handles conversion between formats.
A conversion toward a PDF document requires an intermediary LaTeX document,
this LaTeX document is then processed by a a LaTeX engine into pdf.
Most of the expected functionnalities are translated via Pandoc, however,
sometimes, LaTeX functionnalities are not covered and they must be conveyed
from the original R Markdown document to the LaTeX document.

{{<mermaid align="left">}}
sequenceDiagram
    participant Rmd
    participant md
    participant tex
    participant pdf
    Rmd->>pdf: rmarkdown::pdf_document()
    Rmd->>md: R
    Note right of Rmd: rmarkdown arguments
    md->>+tex: Pandoc
    Note right of md: LaTeX Variables
    tex-->>-pdf: LaTeX engine
    Note right of tex: Extra depencendies</br>e.g. fancyhdr
{{< /mermaid >}}

- The yaml frontmatter won't be self sufficient anymore, the use of 
`include/in_header` points at a supplementary `.tex` file:
    + yaml:
    ```yaml
    ---
    title: "Rmd to PDF"
    output:
      pdf_document:
        latex_engine: xelatex
        keep_md: true
        toc: true
        includes:
          in_header: "preamble.tex"
    mainfont: DejaVuSansMono
    ---
    ```
    + `preambule.tex`:
    ```tex
    \usepackage{fancyhdr}
    \pagestyle{fancy}
    \fancyhead[L]{FCollin}
    ```
- The use of `pdf_document()` is an interesting alternative, maybe more
  compact:
  ```r
  rmarkdown::render(
    input = "rmd2pdf_01_04.Rmd",
    output_format = rmarkdown::pdf_document(
      toc = TRUE,
      latex_engine = "xelatex",
      pandoc_args = list("--variable=mainfont:DejaVuSansMono"),
      extra_dependencies = list(
        rmarkdown::latex_dependency(
          "fancyhdr",
          extra_lines = paste(
            "\\pagestyle{fancy}",
            "\\fancyhead[L]{FCollin}"
          )
        )
      )
    )
  )
  ```

