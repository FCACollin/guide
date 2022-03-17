---
title: "Guide"
date: 'Wednesday, March 10, 2021'
tags:
- hugo
- guide
---


# Welcome

*2022-03-17, FCA Collin*

------------------------------------------------------------------------

This guide contains information for stakeholders about methods used in
when I develop programs. This is still a fairly new initiative and is
likely to strongly evolve in the coming months.


# Under The Hood

This is an example of static web page generated with **Hugo**.
No big knowledge of `html`, Hugo comes with ready-to-use features, further
augmented by themes .
For instance,
the [_learn theme_](http://github.com/matcornic/hugo-theme-learn) used for
these pages has nice features for project documentation, included but not
restricted to:

- keyword search box in the top-left corner.
- content folder structure corresponding to the left expandable navigation
menu.
- the code is highlighted.

<div class="notices tip">
<p>Try the search box in the top-left corner and look for <i>ggplot2</i>.</p>
</div>

Different themes serve different purpose, I have found the 
[_Creative portfolio_](https://themes.gohugo.io/hugo-creative-portfolio-theme/)
especially useful to present my ... 
[portfolio!](https://fcacollin.github.io/Latarnia)

_GitHub [repository](https://github.com/FCACollin/Portfolio),
check directory `hugo`._

The user simply edits the `content` folder with markdown files, adds 
figures, docs, or other elements in the `static folder and run the
command `hugo` to render the webpage in the `public` folder.
Nicely, with the following comment the website is dynamically rendered
at <http://localhost:1313/> and modifications of the source are automatically
rendered.

```
hugo server
```

# Credits

- [Hugo-theme-learn](http://github.com/matcornic/hugo-theme-learn) is a theme
for [Hugo](https://gohugo.io/), a fast and modern static website engine written
in Go.

[modeline]: # ( vim: set foldlevel=0 spell spelllang=en_gb: ) 
