#!/bin/sh


  
cd helm-repository  

mkdir -p /home/runner/.helm/repository/local
for chart in `find ../charts/stable -type d -maxdepth 1`
do
  echo Processing: $chart
  helm lint $chart
  helm package $chart
done

helm repo index --url https://cevalogistics.github.io/ . 2>/dev/null

mkdir work  && cd work

git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_USERNAME"

git clone https://github.com/cevalogistics/cevalogistics.github.io

cd cevalogistics.github.io

cp ../../* . 2>/dev/null

for chart in `find . -name '*.tgz'`
do
  pc=`echo $chart | sed -e 's/\.tgz//g'`
  echo  " * $pc"  >> index.md
done

git add .
git commit -m 'Refresh Repository'

git push --repo https://$GIT_USERNAME:$GIT_PASSWORD@github.com/cevalogistics/cevalogistics.github.io
