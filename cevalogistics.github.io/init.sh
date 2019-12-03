#!/bin/sh


git pull  
rm -rf ./helm-chart-sources 2>/dev/null
mkdir ./helm-chart-sources && cd ./helm-chart-sources/

git clone https://github.com/cevalogistics/etcd-make-mirror.git
git clone https://github.com/cevalogistics/multi-cluster-dns.git

cd ..

helm lint helm-chart-sources/*

helm package helm-chart-sources/*

helm repo index --url https://cevalogistics.github.io/ .

git add .
git commit -m 'Refresh'
git push
