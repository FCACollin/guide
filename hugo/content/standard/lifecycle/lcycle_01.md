---
author: 'FCA Collin, Ph.D.'
date: 'Wednesday, March 05, 2021'
tags:
- lifecycle
title: Lifecycle
weight: '-210309'
---

*2021-03-09, FCA Collin*


_Presentation of lifecycle status and shields used in production_

------------------------------------------------------------------------

<!--more-->

## Document Edition

### In Edit 

![_In Edit Shield_](./img/doc_inedit.svg)

The _Doc/In Edit_ shield indicates a section or document being currently
edited. For the sake of comunication with the stakeholder, the document
(or section within the document) may nonetheless have been released in
spite of not having reach _stability_. This section/document is:

- unstable, likely to evolve.
- not validated: use the information within this section at your own risk.
- open for general overview and major comments.
- closed to minor comments.


## Versioning

Version increment is based on [semver.org](https://semver.org/).
It is given such as MAJOR.MINOR.PATCH; increment in:
 
1. MAJOR version marks incompatible API changes.
2. MINOR version adds new functionality in a backwards compatible manner.
3. PATCH version corrects bug in a backwards-compatible fashion.
4. (Additional numbers as extension to the MAJOR.MINOR.PATCH format
    are used to mark pre-release changes.)

## Emojis for log

| Type       | Title          | Description                                  |
| ---------- | ---------------| ---------------------------------------------|
|✨ `feat`   | Features       | A new feature                                |
|🐛 `fix`    | Bug Fixes      | A bug Fixi                                   |
|📚 `docs`   | Documentation  | Documentation only changes                   |
|💎 `style`  | Styles         | Changes that do not affect the meaning of the|
|            |                |   code (white-space, formatting, missing     |
|            |                |   semi-colons, etc)                          |
|📦 `refact` | Refactoring    | A code change that neither fixes a bug nor   |
|            |                |   adds a feature                             |
|🚀 `perf`   | Perf. Improvt  | A code change that improves performance      |
|🚨 `test`   | Tests          | Adding or correcting tests                   |
|🛠 `build`  | Builds         | Changes that affect the build system         |
|⚙️  `ci`     | CI             | Changes to our CI configuration              |
|♻️  `chore`  | Chores         | Other changes                                |
|🗑 `revert` | Reverts        | Reverts a previous commit                    | 


