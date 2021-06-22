---
author: 'FCA Collin, Ph.D.'
date: 'Wednesday, March 05, 2021'
tags:
- git
title: Git Translation
weight: '-210309'

---


*2021-06-22, FCA Collin*

_Starting with Git from a user perspective._

## Why should I use Git?

* Back up:
    - If I did a mistake I can roll back to a previously working stage.
* Version control:
    - some versions are definitely working and might be used ...
    - it does not stop me to carry on the programming (e.g. I want to
    add a new feature, I want to correct something) and eventually update
    the project: all is self contained (no copy paste from a draft directory
    to a production one)
* Collaboration:
    - Easy to share code.
    - It can be a communication channel.
    - many users can contribute simultaneously.

## Where is the difficulty?

* With a great power 🕸 ...:
    - Many possibilities, can be overwhelming.
    - But: start with git branching workflow
      (<https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows>).   
* It relies on the Command Line Interface:
    - But: many graphical user interface, including RStudio. 

## Basic command

### Git: I want to ... start!

Starting a git repository is simple, in the terminal `git init`. Where the
command is invoked, it makes a `.git` directory which will contain the git base.
However, creating a git directory is not enough, the user must decide if
a file should be version controled.

### Git: I want to keep track of a new file.

Using `git add myfile` must be understand as _Git, I would like to check the
evolution of the file `myfile`._ Then for every change or stage I would like
to keep track of: `git commit myfile -m "An informative short description"`.

An alternative way is to add all the files `git add .` and commit all
`git commit -am "Another informative commit desc.`.

Of course, many IDE propose convenient graphical user interface for these
operations: e.g. with RStudio, this action is done by ticking check boxes.

### Git: I don't to track a file, never.

There is this `draft.R` file which I don't want to commit. To do so, I
add a file `.gitignore` where I add the following line:

```
draft.R
```

I could even be more efficient and avoid every single file including
the mention `draft` in its title, I would adapt the `.gitignore` file:

```
*draft*
```

## Branching

### Git: I want to create a draft version of the project.

Git always commit modifications in a _branch_, the default branch is called
_master_. The command `git branch` returns the list of branches:

```
* master
```

With the command `git checkout -b draft` I am creating and checking out
a new branch (`-b` named `draft`). All commits will be added in that branch.
Looking at `git branch` I definitelly have two branches, the checked-out
branch:

```
* devel
  master
```

And I can check out the master branch again with `git checkout master`.

### Git, I want to merge devel in master

I am satisfied with the modification I made in master, I tested it works
and does not break the previous features. This modification is in the
_devel_ branch, I want to add it to the main branch. Then I need to
check out the destination branch `git checkout master`, and
merge with `git merge devel`. In that case, all my commits will now be part
of the main branch (it has been _fast forwarded_, git terminology).
If I want to by pass these intermediate commit and just merge the
final result, I would use `git merge devel --no-ff -m "With a message"`.


### Git, I believe you, but I want to see the branches

With `git log` all the commits will be visible, you can track back the full
history of the work. You can define your log differently setting some
optionss, e.g. `git log --graph --all --decorate --oneline`:

```
*   5136332 (HEAD -> main, tag: v0.3.4, origin/main) Release
|\
| *   a94f0c0 (origin/devel, devel) Addition of GSEA per WGCNA module
| |\
| | * 45fdfb1 (origin/20_gomod, 20_gomod) release
| | * a58bb47 wgcna gsea go - ready
| | * 42df79e per-module geneset selection
| | * 5b7dd98 ongoing draft for gsea per wgcna module
| | * b221a86 ongoing draft: go per module
| |/
| * 668307c Up version
|/
* c0b4475 minor fix
*   2557230 Release version 0.3.3
|\
| *   f288328 Results of the miRNA analysis.
| |\
| | * 46fabb6 (origin/19_mirna, 19_mirna) Report review
| | * 8aec514 clean
| | * fc0b74a Refactoring for consistent VST normalisation
| | * c16d08e mirna traits cor training
| | * 5fc87aa mir: trait to gene correlation matrix, ongoing
| | * c422edc Fig022 and improvement Fig008
| | * dc3f46a Fig021 miRNA volcano Training All
| | * 19c9077 Fig020 mRNA volcano Training All
| | *   f9db6fc up version
| | |\
| |/ /
|/| /
| |/
| * a47a792 Up version
* |   8cf34f9 (tag: v0.3.2) Delivery
|\ \
| |/
| *   56c2f92 Production
| |\
| | * 02683e7 (18_rnaseq_res) add wgcna results
| | * ace4aa1 (origin/18_rnaseq_res) export module gene in table and graph
| | * 93bdaa9 Fig014 and Fig015 WGCNA Baseline
| | * f11910f WGCNA cut in pieces
| | * 074da27 WGCNA up scalling and modules
| | * 6205e38 WGCNA object for upscaling (case A and B)
| | * d0bc2e6 Prototype for trait to gene correlation matrix
| | * fa4a938 Network - start with ME to traits correlations
| | * efb67cc WGCNA: ind cluster and sft threshold
| | * 21c09f8 Started WGCNA
| | *   0f75d87 Merge branch 'main' into 18_rnaseq_res
| | |\
| |_|/
|/| |
* | |   e73c97e (tag: v0.3.1) Release
|\ \ \
| |/ /
| | * 49ce03c Up-versioned
```

And if you want it cool: <https://www.gitkraken.com/>.

## Cloning

### Git: I want to have my copy of the work.

For that I need to _clone_ the
repository; the command `git clone /file/path/to/the/repo`, will make
a copy of it in a new folder `repo` where the command was invoked. What
is happening? Git is defining a communication channel, communication involves
two parties:

- an emettor, later call the _local_.
- a receptor, later called a _remote_.

This new `repo` folder is the local, and it communicates with the remote
`/file/path/to/the/repo`. Generally, there are two ways of communications:

- pulling: we take information from the _remote_ (e.g. you can pull a branch)
- pushing: we send information to the _remote_ (e.g. you can push a branch).

### Git: I want to participate to a project

Working with a copy of the work (see above), I can create a branch in my local
machine. Once I did that, I should decide which branch is the starting point
to contribute (we should expect devel, industry standard). Then I would create
my own branch which will be synchronised with the remote location.
Later, I will be able, distintly to:

- add new modification to my branch (commits)
- and send them to the corresponding branch in the remote:
  `git push origin 01_mybranch`.
    + even better:
        * firt time I _push_: `git push -u origin 01_mybranch`
          (`-u` for set upstream)
        * then for the future _push_ `git push`.
 
My branch can be used for:

- proposing new features.
- communicating feedback.
- fork the project to adapt to my own needs.

