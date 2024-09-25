# F1 環境設定
## 註冊 iService
- https://man.twcc.ai/@f1-manual/iService
## 特殊工作節點操作流程 
- https://f1-stn01.nchc.org.tw/
- https://f1-stn02.nchc.org.tw/
## 啟動 Notebook
- https://f1-stn02.nchc.org.tw/pun/sys/dashboard
## SSHPROXY, 開啟終端機, 執行以下其中一項連線 (請修改12345為一大於10000的隨機數字) 
```
ssh -D ${HOSTNAME}:12345 ilgn01
ssh -fND ${HOSTNAME}:12345 ilgn01
ssh -D ${HOSTNAME}:12345 intgpn01
ssh -fND ${HOSTNAME}:12345 intgpn01
```
## Bash 環境變數 (12345請同步更動為上述的隨機數字)
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

## Create env and pip install package
```bash
ml tools/miniconda3 
#conda env remove -n nvflare
conda create -n nvflare python=3.10 -y
conda activate nvflare
conda install pysocks
python -m pip install --upgrade pip
pip install nvflare
pip install ipykernel
python -m ipykernel install --name nvflare --user
#pip install -r requirements nvflare
conda deactivate
```

## Activate Conda env, NVFLARE
```bash
ml tools/miniconda3 
conda activate nvflare
```

## 啟動jupyter notebook
```
f1/course/03-nvflare/nvflare_demo.ipynb
```
## 初始環境設定
```python
import os
from pathlib import Path
HOME = str(Path.home())
Add_Binarry_Path=HOME+'/.conda/envs/nvflare/bin'
os.environ['PATH']=os.environ['PATH']+':'+Add_Binarry_Path
```
