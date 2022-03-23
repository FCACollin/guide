---
title: "02 - Templates and extended features"
date: 2022-03-15T09:22:43+01:00
bibliography: ref/ref.bib
tags:
- rmd
---

## 1 - Introduction

In the previous section, the pipeline behind the knit-click from the RStudio
interface was scrutinized to understand what tools are actucally involved,
what argument they can respectively digest, and how to pass them from the
R high level functions. It results that the fine tuning of the output is
accessible. However, the use of these options can be combersum, and
may not be very end-user friendly. A sensible user expectation is that once
an output is well configured, these should be translated into a template much
easier to reuse, hidding the unnecessary complexity, and only showing
the options that are desirable. This is where templates becomes handy.


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
    tex-->>pdf: LaTeX template
    Note right of tex: e.g. Eisvogel
{{< /mermaid >}}


## 2. Material and Methods

A series of minimum working examples was generated to support the demonstration.
The examples were built at the same time as the results below were reported.

The environment for the examples was containerized, a docker image and
its definition was used to ensure reproducibility and / or enable the extenssion
of the work (Nüst et al. 2020).
The Docker definition was made publicly available at
<https://github.com/FCACollin/ayup_dock>.

In addition, the template used for this example was _eisvogel_, an open-source
LaTeX template for Pandoc, available in
[GitHub](https://github.com/Wandmalfarbe/pandoc-latex-template).
(Wagler and MacFarlane, 2021).

## 3. Results

The template _eisvogel_ was cloned from the GitHub to a directory
`pandoc/eisvogel`, location given in reference to the own location of the
R Markodwn file calling the template. In addition, the file `eisvogel.tex`
was renamed as `eisvogel.latex`.

The LaTeX template is simply used through an expected `template` argument
handled by `pdf_document`. Therefore the yaml fronmt matter is such as:

```yaml
---
title: "R Markdown to PDF"
subtitle:
    The compexity can be alleviated with the use of templates\newline
    e.g. _Eisvogel_ 
    ([Pascal Wagler](https://github.com/Wandmalfarbe/pandoc-latex-template))
author: FCA Collin
date: "`r format(Sys.Date(), '%d %B %Y')`"
output:
  pdf_document:
    template: pandoc/eisvogel/eisvogel
    latex_engine: xelatex
titlepage: true
titlepage-color: "3F682E"
titlepage-rule-color: "FFFFFF"
titlepage-text-color: "FFFFFF"
---
```

The template comes with it own arguments, which complete the Pandoc
LaTeX variables, that is whjy, to be used, they just need to be declared as
extra configuration lines in the yaml section (e.g. `titlepage`).

[Open the pdf example.](pdf/rmd2pdf_02_01.pdf)

{{<embed-pdf url="pdf/rmd2pdf_02_01.pdf" width="100">}}

## 4. Discussion

## References

Nüst, Daniel, Vanessa Sochat, Ben Marwick, Stephen J Eglen, Tim Head,
Tony Hirst, and Benjamin D Evans. 2020. “Ten Simple Rules for Writing
Dockerfiles for Reproducible Data Science.” Public Library of Science
San Francisco, CA USA. <https://doi.org/10.1371/journal.pcbi.1008316>.

Wagler, Pascal, and John MacFarlane. 2021. “Eisvogel Pandoc Latex
Template.” GitHub Wandmalfarbe.
<https://github.com/Wandmalfarbe/pandoc-latex-template>.

