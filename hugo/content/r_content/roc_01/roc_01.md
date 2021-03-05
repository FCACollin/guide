---
author: 'FCA Collin, Ph.D.'
date: 'Wednesday, January 13, 2021'
tags:
- ROC
- graph
- ggplot2
title: ROC Curves
weight: '-210110'
---

*2021-01-11, FCA Collin (update 2021-01-12)*

------------------------------------------------------------------------

<!--more-->
Presentation
============

The Receiver Operating Characteristic (ROC) is a general representation
of a binary classifier; it accounts for:

-   the sensitivity (the proportion of real positive case detected),
-   the false positive rate (1 - sensitivity),
-   the general performance via the area under the ROC curve (AUC).

The classifier for the example identifies tumour tissues (yes/no) in the
case of lung cancer (LC) or eventually identifies the Squamous Cell
Carcinoma (SCC) histological subtype. The dataset used for the graphic
requires at least columns for the sensitivity, the false-positive rate
and a decision rule represented by a threshold proportion, in that case
varying from 0 to 1. Additionally, information about the classifier
itself can include the model identification (LC, SCC), as well as the
AUC (+ confidence interval estimation) as a overall evaluation of the
models.

Data
====

Lets `dtaplot` being as example dataset such as:

<table>
<caption>First row of the dataset behind the ROC curves.</caption>
<thead>
<tr class="header">
<th style="text-align: right;">Threshold</th>
<th style="text-align: right;">Sensitivity</th>
<th style="text-align: right;">Specificity</th>
<th style="text-align: right;">FalseAlarm</th>
<th style="text-align: right;">ntree</th>
<th style="text-align: left;">auc.ci</th>
<th style="text-align: right;">auc</th>
<th style="text-align: left;">Diag</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">10000</td>
<td style="text-align: left;">0.925-0.984</td>
<td style="text-align: right;">0.954</td>
<td style="text-align: left;">2) SCC</td>
</tr>
<tr class="even">
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">10000</td>
<td style="text-align: left;">0.938-0.989</td>
<td style="text-align: right;">0.964</td>
<td style="text-align: left;">1) LC</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.96445</td>
<td style="text-align: right;">0.0097087</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">10000</td>
<td style="text-align: left;">0.925-0.984</td>
<td style="text-align: right;">0.954</td>
<td style="text-align: left;">2) SCC</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.95860</td>
<td style="text-align: right;">0.0194175</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">10000</td>
<td style="text-align: left;">0.925-0.984</td>
<td style="text-align: right;">0.954</td>
<td style="text-align: left;">2) SCC</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.95375</td>
<td style="text-align: right;">0.0291262</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">10000</td>
<td style="text-align: left;">0.925-0.984</td>
<td style="text-align: right;">0.954</td>
<td style="text-align: left;">2) SCC</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.95285</td>
<td style="text-align: right;">0.0388350</td>
<td style="text-align: right;">1</td>
<td style="text-align: right;">0</td>
<td style="text-align: right;">10000</td>
<td style="text-align: left;">0.925-0.984</td>
<td style="text-align: right;">0.954</td>
<td style="text-align: left;">2) SCC</td>
</tr>
</tbody>
</table>

Some decision rules (threshold) were of interest:

-   `Min. error` is the threshold for which the classifier overall error
    was at its minimum.
-   `Sens. 90%`: has its better not to miss true positive patients, the
    threshold may be determined so as to catch 90% of true positive
    patient (sensibility), eventually at a cost in terms of overall
    error as it then automatically increase the false-alarm rate.

Lets `threshold` being the supplementary data characterising this two
decision rules:

<table style="width:98%;">
<caption>`Threshold, the decision rules.</caption>
<colgroup>
<col style="width: 10%" />
<col style="width: 11%" />
<col style="width: 11%" />
<col style="width: 10%" />
<col style="width: 6%" />
<col style="width: 11%" />
<col style="width: 6%" />
<col style="width: 8%" />
<col style="width: 10%" />
<col style="width: 10%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: right;">Threshold</th>
<th style="text-align: right;">Sensitivity</th>
<th style="text-align: right;">Specificity</th>
<th style="text-align: right;">FalseAlarm</th>
<th style="text-align: right;">ntree</th>
<th style="text-align: left;">auc.ci</th>
<th style="text-align: right;">auc</th>
<th style="text-align: left;">Diag</th>
<th style="text-align: right;">target</th>
<th style="text-align: left;">Rational</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">0.48965</td>
<td style="text-align: right;">0.9368421</td>
<td style="text-align: right;">0.9375000</td>
<td style="text-align: right;">0.0625000</td>
<td style="text-align: right;">10000</td>
<td style="text-align: left;">0.938-0.989</td>
<td style="text-align: right;">0.964</td>
<td style="text-align: left;">1) LC</td>
<td style="text-align: right;">0.0103500</td>
<td style="text-align: left;">Min. error</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.49350</td>
<td style="text-align: right;">0.8640777</td>
<td style="text-align: right;">0.9813953</td>
<td style="text-align: right;">0.0186047</td>
<td style="text-align: right;">10000</td>
<td style="text-align: left;">0.925-0.984</td>
<td style="text-align: right;">0.954</td>
<td style="text-align: left;">2) SCC</td>
<td style="text-align: right;">0.0065000</td>
<td style="text-align: left;">Min. error</td>
</tr>
<tr class="odd">
<td style="text-align: right;">0.69835</td>
<td style="text-align: right;">0.9000000</td>
<td style="text-align: right;">0.9687500</td>
<td style="text-align: right;">0.0312500</td>
<td style="text-align: right;">10000</td>
<td style="text-align: left;">0.938-0.989</td>
<td style="text-align: right;">0.964</td>
<td style="text-align: left;">1) LC</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: left;">Sens. 90%</td>
</tr>
<tr class="even">
<td style="text-align: right;">0.35290</td>
<td style="text-align: right;">0.9029126</td>
<td style="text-align: right;">0.9441860</td>
<td style="text-align: right;">0.0558140</td>
<td style="text-align: right;">10000</td>
<td style="text-align: left;">0.925-0.984</td>
<td style="text-align: right;">0.954</td>
<td style="text-align: left;">2) SCC</td>
<td style="text-align: right;">0.0029126</td>
<td style="text-align: left;">Sens. 90%</td>
</tr>
</tbody>
</table>

Graphic
=======

The example is based on the package `ggplot2`, plus the optional
`ggthemr` which provides graphical themes, for instance the theme`flat`.

    library(ggplot2)
    if(require(ggthemr)) ggthemr::ggthemr("flat")

Basic
-----

The minimal ROC representation is simply a line plot representing the
sensitivity as a function of the false alarm rate, for one or the other
model.

```r
ggplot(
data = dtaplot,
mapping = aes(
  x = FalseAlarm,
  y = Sensitivity,
  color = Diag
)
) + geom_line(
lwd = 1
) + facet_grid(
. ~ Diag
)
```

![](img/figure_01-1.png)

Aesthetic improvement
---------------------

Aesthetic can help improving the reading:

-   the area under the curve is of interest, therefore it can be filled.
-   the bisector delimits a model performing as good as a decision made
    flipping a coin (the reference model).
-   sensibility and false-alarm rate are define from 0 to 1, the length
    of this two axis should equal.

<!-- -->

    {
      ggplot(
        data = dtaplot,
        mapping = aes(
          x = FalseAlarm,
          y = Sensitivity,
          ymax = Sensitivity,
          fill = Diag,
          color = Diag
        )
        ) + geom_ribbon(
        ymin = 0, alpha = .5, color = NA
        ) + geom_line(
        lwd = 1
        ) + geom_abline(
        slope = 1, intercept = 0, col = "gray50", lwd = 2, lty = 2
        ) + xlab(
        "False Alarm Rate (1 - specificity)"
        ) + facet_grid(
        . ~ Diag
        ) + theme(
        asp = 1
      )
    }

![](img/unnamed-chunk-5-1.png)

Other data for more annotations
-------------------------------

The use of the model for diagnostic demands to define a threshold,
various rational can be used, in the example two thresholds were
defined: the minimal error, the 90% detection of positive case. Points
can identify this threshold and performance on the ROC curve.

    {
      ggplot(
        data = dtaplot,
        mapping = aes(
          x = FalseAlarm,
          y = Sensitivity,
          ymax = Sensitivity,
          fill = Diag,
          color = Diag
        )
        ) + geom_ribbon(
        ymin = 0, alpha = .5, color = NA
        ) + geom_line(
        lwd = 1
        ) + geom_abline(
        slope = 1, intercept = 0, col = "gray50", lwd = 2, lty = 2
        ) + xlab(
        "False Alarm Rate (1 - specificity)"
        ) + facet_grid(
        . ~ Diag
        ) + theme(
        asp = 1
        ) + geom_point(
        data = threshold,
        mapping = aes(shape = Rational, colour = Rational),
        size = 3
      )
    }

![](img/unnamed-chunk-6-1.png)

The plot can be further personalised manipulating the theme locally to
address for instance the positioning of the legend and other settings.

    {
      ggplot(
        data = dtaplot,
        mapping = aes(
          x = FalseAlarm,
          y = Sensitivity,
          ymax = Sensitivity,
          fill = Diag,
          color = Diag
        )
        ) + geom_ribbon(
        ymin = 0, alpha = .5, color = NA
        ) + geom_line(
        lwd = 1
        ) + geom_abline(
        slope = 1, intercept = 0, col = "gray50", lwd = 2, lty = 2
        ) + xlab(
        "False Alarm Rate (1 - specificity)"
        ) + facet_grid(
        . ~ Diag
        ) + geom_point(
        data = threshold,
        mapping = aes(shape = Rational, colour = Rational),
        size = 3
        ) + theme(
        asp = 1, legend.position = "bottom",
        legend.text = element_text(size = 8),
        legend.title = element_text(size = 8),
        legend.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill = alpha("white", .5), colour = 'white')
      )
    }

![](img/unnamed-chunk-7-1.png)

Final
-----

Finally, as a last piece of annotation, the AUC given with its
confidence interval may help for further comparison.

    {
      ggplot(
        data = dtaplot,
        mapping = aes(
          x = FalseAlarm,
          y = Sensitivity,
          ymax = Sensitivity,
          fill = Diag,
          color = Diag
        )
        ) + geom_ribbon(
        ymin = 0, alpha = .5, color = NA
        ) + geom_line(
        lwd = 1
        ) + geom_abline(
        slope = 1, intercept = 0, col = "gray50", lwd = 2, lty = 2
        ) + xlab(
        "False Alarm Rate (1 - specificity)"
        ) + facet_grid(
        . ~ Diag
        ) + geom_point(
        data = threshold,
        mapping = aes(shape = Rational, colour = Rational),
        size = 3
        ) + theme(
        asp = 1, legend.position = "bottom",
        legend.text = element_text(size = 8),
        legend.title = element_text(size = 8),
        legend.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill = alpha("white", .5), colour = 'white')
        ) + geom_label(
        data = aggregate(auc.ci ~ Diag + ntree, data = dtaplot, unique),
        mapping = aes(label = auc.ci, ymax = NULL, fill = NULL, color = NULL ,
          x = .5, y = .5
        )
      )
    }

![](img/unnamed-chunk-8-1.png)

    sessionInfo()

    ## R version 4.0.3 (2020-10-10)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Debian GNU/Linux 10 (buster)
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/openblas/libblas.so.3
    ## LAPACK: /usr/lib/x86_64-linux-gnu/libopenblasp-r0.3.5.so
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_GB.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=en_GB.UTF-8        LC_COLLATE=en_GB.UTF-8    
    ##  [5] LC_MONETARY=en_GB.UTF-8    LC_MESSAGES=en_GB.UTF-8   
    ##  [7] LC_PAPER=en_GB.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=en_GB.UTF-8 LC_IDENTIFICATION=C       
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] ggthemr_1.1.0 ggplot2_3.3.2
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] knitr_1.29       magrittr_1.5     tidyselect_1.1.0 munsell_0.5.0   
    ##  [5] colorspace_1.4-1 R6_2.4.1         rlang_0.4.7      dplyr_1.0.2     
    ##  [9] stringr_1.4.0    highr_0.8        tools_4.0.3      grid_4.0.3      
    ## [13] gtable_0.3.0     xfun_0.16        withr_2.2.0      htmltools_0.5.0 
    ## [17] ellipsis_0.3.1   yaml_2.2.1       digest_0.6.25    tibble_3.0.3    
    ## [21] lifecycle_0.2.0  crayon_1.3.4     farver_2.0.3     purrr_0.3.4     
    ## [25] vctrs_0.3.4      glue_1.4.2       evaluate_0.14    rmarkdown_2.3   
    ## [29] labeling_0.3     stringi_1.4.6    compiler_4.0.3   pillar_1.4.6    
    ## [33] generics_0.0.2   scales_1.1.1     pkgconfig_2.0.3
