---
title: "Templates and extended features"
menuTitle: "02 - Templates and extended features"
weight: 02
date: 2022-03-25
bibliography: ref/ref.bib
description:
  "Advanced usage: why and how to use a LaTeX template?
   How to handle references?"
tags:
- rmd
---

## 1. Introduction

In the previous section, the pipeline behind the knit-click from the RStudio
interface was scrutinized to understand what tools are actucally involved,
what argument they can respectively digest, and how to pass them from the
R high level functions. It results that the fine tuning of the output is
at hand.

However, the use of these options can be combersum, and
may not be very end-user friendly. A sensible user expectation is that once
an output is well configured, these should be translated into a template much
easier to reuse, hidding the unnecessary complexity, and only showing
the options that are desirable. This is where templates becomes handy.

This section is providing a demonstration of how the concept of Pandoc
templates can be leveraged to set up a report. It is completed by an additional
feature, not tied up to the template topic, but so convenient: the
handling of references.

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

### 3.1 Use templates

The template _eisvogel_ was cloned from the GitHub to a directory
`pandoc/eisvogel`, location given in reference to the own location of the
R Markodwn file calling the template. In addition, the file `eisvogel.tex`
was renamed as `eisvogel.latex`.

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

{{< unsafe >}}
<iframe src="pdf/rmd2pdf_02_01.pdf" height="800" width="100%"></iframe>
{{< /unsafe >}}


### 3.2 Manage bibliographic references

LaTeX handles bibliographic references with [BibTex](http://www.bibtex.org/).
Pandoc has developed a filter: `citeproc` (formerly known as
`pandoc-citeproc`) which handles the
[markdown citations](
https://pandoc.org/demo/example19/Extension-citations.html). 
For a
[R Markdown](https://bookdown.org/yihui/rmarkdown-cookbook/bibliography.html)
user this is translated into a simple field referencing the BibTeX file.
In addition, a Citation Style Language file
([csl](https://citationstyles.org/),
[Zotero Style Repository](https://www.zotero.org/styles))
can be referenced, it will manage the inline citation style
along with the list of references.


```yaml
---
title: "R Markdown to PDF"
subtitle:
    The addition of citation management
author: FCA Collin
date: "`r format(Sys.Date(), '%d %B %Y')`"
output:
  pdf_document:
    template: pandoc/eisvogel/eisvogel
    toc: true
    number_sections: true
    latex_engine: xelatex
bibliography: ref/ref.bib
csl: ref/csl/field-crops-research.csl
titlepage: true
titlepage-color: "354C71"
titlepage-rule-color: "FFFFFF"
titlepage-text-color: "FFFFFF"
toc-own-page: true
colorlinks: true
---
```

A BibTex list of references is a simple text file as formated below. Note that
graphical user interfaces can be used to handle it, such as the lightweight
opensource [JabRef](https://www.jabref.org/). Note that the BibTex format is
also used for R package citations.

```bibtex
% Encoding: UTF-8

@Article{Florindo2020,
  author    = {Florindo, Helena F and Kleiner, Ron and Vaskovich-Koubi, Daniella and Ac{\'u}rcio, Rita C and Carreira, Barbara and Yeini, Eilam and Tiram, Galia and Liubomirski, Yulia and Satchi-Fainaro, Ronit},
  title     = {Immune-mediated approaches against COVID-19},
  journal   = {Nature nanotechnology},
  year      = {2020},
  volume    = {15},
  number    = {8},
  pages     = {630--645},
  doi       = {10.1038/s41565-020-0732-3},
  publisher = {Nature Publishing Group},
}

@Misc{Nuest2020,
  author    = {N{\"u}st, Daniel and Sochat, Vanessa and Marwick, Ben and Eglen, Stephen J and Head, Tim and Hirst, Tony and Evans, Benjamin D},
  title     = {Ten simple rules for writing Dockerfiles for reproducible data science},
  year      = {2020},
  doi       = {10.1371/journal.pcbi.1008316},
  publisher = {Public Library of Science San Francisco, CA USA},
}

@PhdThesis{Collin2018b,
  author = {Collin, Francois Christophe},
  title  = {The tolerance of wheat (Triticum aestivum L.) to Septoria tritici blotch},
  school = {The University of Nottingham and L’Institut des sciences et industries du vivant et de l’environnement (AgroParisTech)},
  year   = {2018},
}

@Article{Collin2018,
  author    = {Collin, F and Bancal, P and Spink, J and {Kock Appelgren}, P and Smith, J and Paveley, N D and Bancal, M-O and Foulkes, M J},
  title     = {Wheat lines exhibiting variation in tolerance of {S}eptoria tritici blotch differentiated by grain source limitation},
  journal   = {Field Crops Research},
  year      = {2018},
  volume    = {217},
  pages     = {1-- 10},
  month     = {March},
  issn      = {0378-4290},
  doi       = {10.1016/j.fcr.2017.11.022},
  groups    = {Collin2018},
  keywords  = {STB},
  owner     = {fcollin},
  timestamp = {2017.12.09},
  url       = {https://www.sciencedirect.com/science/article/pii/S0378429017312078},
}

@Article{Kapica-Topczewska2019a,
  author    = {Kapica-Topczewska, Katarzyna AND Tarasiuk, Joanna AND Collin, Francois AND Brola, Waldemar AND Chorąży, Monika AND Czarnowska, Agata AND Kwaśniewski, Mirosław AND Bartosik-Psujek, Halina AND Adamczyk-Sowa, Monika AND Kochanowicz, Jan AND Kułakowska, Alina},
  title     = {The effectiveness of interferon beta versus glatiramer acetate and natalizumab versus fingolimod in a Polish real-world population},
  journal   = {PLOS ONE},
  year      = {2019},
  volume    = {14},
  number    = {10},
  pages     = {1-12},
  month     = {10},
  doi       = {10.1371/journal.pone.0223863},
  publisher = {Public Library of Science},
  url       = {https://doi.org/10.1371/journal.pone.0223863},
}

@Comment{jabref-meta: databaseType:bibtex;}
```

In the markdown text, invoking a citation is easy and clear (check for more
examples of
[markdown citations](
https://pandoc.org/demo/example19/Extension-citations.html)). 

```md
![Schematic representation of SARS-CoV-2 structure. This is an enveloped,
positive-sense RNA virus with four main structural proteins,
including spike (S) and membrane (M) glycoproteins, as well as envelope (E)
and nucleocapsid (N) proteins. Figure and caption from
@Florindo2020.\label{f-intro_covid}](img/florindo2020_covid_drawing.jpg)

The figure \ref{f-intro_covid} cross-referencing is enabled by `\label{}` and
`\ref{}` commands. It refers to a bibtex reference `@Florindo2020` which is
rendered as "@Florindo2020", along with an entry added to the reference list at
the end of the document. The handling of reference is very convenient and
still readable in plain text. For instance if I want to refer
to reproducible science and Docker images [@Nuest2020] the bracketed reference
is added by `[@Nuest2020]`.
Several references can be used so I can refer to several items of my PhD
in a single reference [@Collin2018;@Collin2018b] with
`[@Collin2018;@Collin2018b]`.
This citation system is flexible enough to allow free text within the
citation call [@Kapica-Topczewska2019a, see the Kaplan-Meir step curves];
this last reference is as:
`[@Kapica-Topczewska2019a, see the Kaplan-Meir step curves]`.
```

The text above is rendered in the first section of the document reported below
([open the pdf example](pdf/rmd2pdf_02_02.pdf)).

{{< unsafe >}}
<iframe src="pdf/rmd2pdf_02_02.pdf" height="800" width="100%"></iframe>
{{< /unsafe >}}


## 4. Discussion

R Markdown allows for fine configuration of a pdf document. The large number
of options can be substituted by a template file, while keeping scientif authors
tools such as a en efficient citation manager at hand.

This is only a subset of possibilities, some other tools of interest I
personnaly used in plain LaTeX formats includes:  might
need to be evoked: glossary, list of tables, list of figures, connection
of children documents, several pagination styles and starts within a document
(an example is added as a supplementary section at the end of this page).
I expect them to be also accessible from the R Markdown interface.

Perpsectives:

- the concept of Pandoc templates is not limited to LaTeX processing, it
  is also found for instance for docs and html content. Those interested
  in docx or other output should explore the templating capabilities.
- the complex examples above use a yaml configuration, but the rendering
  of the document still relies on `rmarkdown::pdf_document()`. Once a template
  is ready and stable, I suggest the next step would be to create and export
  a custom `pdf_document()` function such as `my_super_report()` that
  would be invoked directly into the yaml front matter, hence, anybody could
  leverage this new format.
  ```yaml
  ---
  title: "R Markdown to PDF"
  author: FCA Collin
  date: "`r format(Sys.Date(), '%d %B %Y')`"
  output: my_super_report
  ---
  ```

## References

Nüst, Daniel, Vanessa Sochat, Ben Marwick, Stephen J Eglen, Tim Head,
Tony Hirst, and Benjamin D Evans. 2020. “Ten Simple Rules for Writing
Dockerfiles for Reproducible Data Science.” Public Library of Science
San Francisco, CA USA. <https://doi.org/10.1371/journal.pcbi.1008316>.

Wagler, Pascal, and John MacFarlane. 2021. “Eisvogel Pandoc Latex
Template.” GitHub Wandmalfarbe.
<https://github.com/Wandmalfarbe/pandoc-latex-template>.


## Supplementary

Example of complex document handled by LaTeX, all the options used in this
document are accessible from the R Markdown interface
[(Collin 2018, PhD manuscript)](
https://pastel.archives-ouvertes.fr/tel-02443529/document):

{{< unsafe >}}
<iframe src="https://pastel.archives-ouvertes.fr/tel-02443529/document" height="1000" width="100%"></iframe>
{{< /unsafe >}}


[modeline]: # ( vim: set foldlevel=0 spell spelllang=en_gb: )

