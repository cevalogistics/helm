#!/bin/sh


  
cd helm-repository  

helm lint ../charts/stable/*
helm package ../charts/stable/*

helm repo index --url https://cevalogistics.github.io/ . 2>/dev/null

mkdir work  && cd work
 

git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_USERNAME"

git clone https://github.com/cevalogistics/cevalogistics.github.io

cd cevalogistics.github.io

cp ../../* . 2>/dev/null

git add .
git commit -m 'Refresh Repository'

git push --repo https://$GIT_USERNAME:$GIT_PASSWORD@github.com/cevalogistics/cevalogistics.github.io
