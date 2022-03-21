---
title: "02 - Templates and extended features"
date: 2022-03-15T09:22:43+01:00
bibliography: ref/ref.bib
tags:
- rmd
---

## 1 - Introduction

In the previous section, 


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


## 2. Material and Methods

A series of minimum working examples was generated to support the demonstration.
The examples were built at the same time as the results below were reported.

The environment for the examples was containerized, a docker image and
its definition was used to ensure reproducibility and / or enable the extenssion
of the work (Nüst et al. 2020).
The Docker definition was made publicly available at
<https://github.com/FCACollin/ayup_dock>.


## 3. Results

## 4. Discussion

## References

Nüst, Daniel, Vanessa Sochat, Ben Marwick, Stephen J Eglen, Tim Head,
Tony Hirst, and Benjamin D Evans. 2020. “Ten Simple Rules for Writing
Dockerfiles for Reproducible Data Science.” Public Library of Science
San Francisco, CA USA. <https://doi.org/10.1371/journal.pcbi.1008316>.

