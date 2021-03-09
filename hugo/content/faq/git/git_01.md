---
author: 'FCA Collin, Ph.D.'
date: 'Wednesday, March 05, 2021'
tags:
- error
- warning
- debug
title: Git Help
weight: '-210305'
---

*2021-03-08, FCA Collin*

------------------------------------------------------------------------

<!--more-->
Common Problems With Git
========================


### I have forgotten to start a feature branch and started modifying the devel

```
git stash
git checkout -b feat_branch
git stash pop
```


