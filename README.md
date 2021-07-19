This this the repo for my [blog](blog.yongcong.wang).

The static website is generated with [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)

A general guideline is as followed:

## Installation
```Bash
pip install mkdocs-material
```

## Generation
```Bash
git clone git@github.com:yongcongwang/note.git &&
cd note &&
mkdocs serve
```

This will hold a live preview server, so you can preview this blog via a browser at [localhost:8000](http://localhost:8000/).

## Publish to remote

I use [github](https://github.com/yongcongwang/note) to hold the code and [Github Pages](https://pages.github.com/) to hold the website.

There are two ways for the deployment:

1. [Github Actions](https://github.com/yongcongwang/note/blob/master/.github/workflows/ci.yml)
2. Manually with the command: `mkdocs gh-deploy --force`

And I prefer the first one.
