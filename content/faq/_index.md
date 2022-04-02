---
title: "FAQ"
description:
    "Frequently Asked Questions"
date: '2022-04-02'
weight: 99
tags:
- tmux
- Docker
aliases:
    - /faq.html # original name
    - /post/2022/04/02.html
---

---

## Docker

### How to push a Docker image to Docker Hub?

- `docker tag fc-nmosd fcacollin/fc-nmosd`
- `docker logout`
- `docker login`
- `docker push fcacollin/fc-nmosd`

### How to save a Docker image locally?

- `docker save fc-nmosd -o fc-nmosd.tar` - test

### How to remove Docker images?

- To remove all danding image: `docker image prune`.
- To remove all unused images: `docker image prune --all`.
- To remove an image `docker image rm`
- To delete all images `docker rmi -f $(docker images -a -q)`

---

## TMUX

### How to copy-paste with tmux?

- navigation `ctrl + [`
- start selection `ctrl + space`
- copy selection `ctrl + w`
- paste selection `ctrl + [`


[modeline]: # ( vim: set foldlevel=0 spell spelllang=en_gb: ) 
