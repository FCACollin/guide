---
author: 'FCA Collin, Ph.D.'
date: '2021-08-T05:49+0000'
tags:
- date
- time
title: Date and Time
weight: '2021-08-T05:49+0000'

---

*2021-08-T05:49+0000, FCA Collin*


_Standard followed to referred to date and time_

------------------------------------------------------------------------

<!--more-->

Date and time follows
[ISO 8601-1:2019](https://www.iso.org/iso-8601-date-and-time-format.html),
"_Date and time - Representations for information interchange -
Part 1: Basic rules_".

With R:

``` r
# Date
format(Sys.time(), "%Y-%m")
#> [1] "2021-08"
format(Sys.time(), "%Y-%m-%d")
#> [1] "2021-08-10"

# Date (compact)
format(Sys.time(), "%Y%m")
#> [1] "202108"
format(Sys.time(), "%Y%m%d")
#> [1] "20210810"

# + Time
format(Sys.time(), "%Y-%m-%dT%R%z")
#> [1] "2021-08-10T06:03+0000"
format(Sys.time(), "%Y%m%dT%R%z")
#> [1] "20210810T06:03+0000"

format(Sys.time(), "%Y-%m-%dT%T%z")
#> [1] "2021-08-10T06:03:19+0000"
format(Sys.time(), "%Y%m%dT%T%z")
#> [1] "20210810T06:03:19+0000"
```

<sup>Created on 2021-08-10 by the [reprex package](https://reprex.tidyverse.org)
(v2.0.0)</sup>

Some side advantages:

- alphabetic order matches chronological order (convenient for ordering)
- unambiguous and largely adopted across the world.

