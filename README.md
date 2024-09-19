# F1 環境設定
## 註冊 iService
- https://man.twcc.ai/@f1-manual/iService
## 特殊工作節點操作流程 
- https://f1-stn01.nchc.org.tw/
- https://f1-stn02.nchc.org.tw/
## 啟動 Notebook
- https://f1-stn02.nchc.org.tw/pun/sys/dashboard
## SSHPROXY, 開啟終端機, 執行以下連線
```
ssh -D ${HOSTNAME}:12345 ilgn01
```
## Bash 環境變數
```
export http_proxy="socks5://${HOSTNAME}:12345"
export https_proxy="socks5://${HOSTNAME}:12345"
```
## Python 環境變數
```
import os
tmp=!echo $(hostname)
HOSTNAME=tmp[0]
os.environ['http_proxy'] = "socks5:/"+HOSTNAME+":12345" 
os.environ['https_proxy'] = "socks5://"+HOSTNAME+":12345" 
```
## 連線測試
```
curl https://www.google.com| iconv -f iso8859-1 -t utf-8 > index.html
```
## 下載套件
```
cd ~/
git clone https://github.com/c00cjz00/f1.git
```
## 下載 Singularity image
- https://docs.qiime2.org/2024.5/install/virtual/docker/
```
mkdir -p /work1/$(whoami)/docker/
cd /work1/$(whoami)/docker/
singularity pull docker://quay.io/qiime2/amplicon:2024.5
singularity pull docker://quay.io/qiime2/metagenome:2024.5
singularity pull docker://quay.io/qiime2/tiny:2024.5
```
## 下載 Biocontainer image
- https://biocontainers.biobank.org.tw/singularity_images.php
```
mkdir -p /work1/$(whoami)/docker/
cd /work1/$(whoami)/docker/
wget --no-check-certificate https://depot.galaxyproject.org/singularity/picrust2%3A2.5.3--pyhdfd78af_0  -O picrust-2.5.3.sif
wget --no-check-certificate https://depot.galaxyproject.org/singularity/humann%3A3.9--py312hdfd78af_0 -O humann-3.9.sif
```
## 建立環境套件
```
# qiime2
f1/course/01-setup/02-singularity_pythonbase_ipykernel.ipynb
# humann
f1/course/01-setup/03-singularity_nonepython_ipykernel.ipynb
```
## Qiime2 範例操作
f1/course/02-qiime2/demo01.ipynb

##  教學文件
- 人體微生物相資料平台教學-大綱 https://hackmd.io/9tAeQiL5QEW9QI_iL8PO8w
- F1教學 https://github.com/c00cjz00/f1/tree/main/course/01-setup
