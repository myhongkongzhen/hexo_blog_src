---
title: Using hexo to create github blog
categories:
  - technology
tags: [hexo, github]
date: 2017-08-01 19:05:51
---
> Using hexo to create  github blog

<!--more-->

# Prepare working
------
- Git
- Node.js & npm & hexo

# Init hexo working space
------
```bash
hexo init myhongkongzhen.github.io
#001_hexo_init

#----------------------------------------------------
cd myhongkongzhen.github.io
git init
git add .
git ci -m"init hexo blog"
#002_git_init
#----------------------------------------------------

git submodule add https://github.com/myhongkongzhen/hexo-theme-next.git themes/next
#003_add_hexo_theme_next

cd themes\next
git remote -v
#004_remote_v_01

git remote add upstream https://github.com/iissnan/hexo-theme-next.git
git remote -v
#004_remote_v_02

git fetch upstream
git merge upstream/master
#004_remote_v_03.jpg

#----------------------------------------------------
git tag
git co -b mystyle v5.1.1
#005_change_release_version_next

#----------------------------------------------------
cd myhongkongzhen.github.io
git remote add origin https://github.com/myhongkongzhen/hexo_blog_src.git
git push -u origin master
#006_add_remote_github

hexo s -g --debug -p8888
#start hexo blog local server
#007_start_hexo

#----------------------------------------------------
npm install hexo-deployer-git --save # deploy to github
npm install hexo-filter-plantuml --save # plantuml
npm install hexo-generator-feed --save # feed
npm install hexo-generator-searchdb --save # local search
npm i --save hexo-wordcount # wordcount

```





