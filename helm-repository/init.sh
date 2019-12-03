#!/bin/sh


  
cd helm-repository  

helm lint ../charts/stable/*
helm package ../charts/stable/*
helm repo index --url https://cevalogistics.github.io/ .

mkdir work
cd work
 

git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_USER"
git config --global user.password "$GIT_PASSWORD"

git clone https://github.com/cevalogistics/cevalogistics.github.io

cd cevalogistics.github.io

cp ../../* . 2>/dev/null

git add .
git commit -m 'Refresh Repository'
git push


ls -lR