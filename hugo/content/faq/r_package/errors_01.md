---
author: 'FCA Collin, Ph.D.'
date: 'Wednesday, March 05, 2021'
tags:
- error
- warning
- debug
title: R Pack Debug
weight: '-210305'
---

*2021-03-05, FCA Collin*

------------------------------------------------------------------------

<!--more-->
Errors and Warnings with R
==========================


### `@export may only span a single line`

- Context: documenting a package with `devtools::document()`
 (`ctrl`+`shift`+`d` in RStudio).
- Problem: I am use to copy my example at the end of the function documentation,
  somtimes I forget to add the `@examples` tag.
- Correction: add `@examples` before the example.
