# Blognotes for ArtisticZhao

## Intro

This is my personal repo, which store my jekyll source code for my blogs and notes.  
The notes will present some useful technical articles. And the blogs will record my life, vlogs, reading notes, etc.  

More important, this blognotes also share with my girl. We will update our sweet love, daily life...

## Theme

- [TeXt Theme](https://github.com/kitian616/jekyll-TeXt-theme)
- [love story](https://github.com/xfbxfbxfb/love)

## Folders

`_posts` I put the blogs in this folder, in the folder the articles' filename must have a date.

`notes` I put my notes in this folder, in the folder the post time is not important, so just ignore it.

## Usage

### posts

Just commit the Markdown file to the `_posts` folder, and the jekyll will auto deal others.

### notes

Keep a note may complex.

- You need put the Markdown file to the `notes` folder in the right category.
- Add the url into the `navigation.yml`, which located '_data/navigation.yml'

### generate static webpages

```shell
bundle exec jekyll s
```

### upload webpages to server

```shell
./upload.sh
```

This shell script will tar the `_site` folder, and upload to my VPS via scp (the scp use ssh key to identify).
And execute extract command to modify file to nginx website folder.
