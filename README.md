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
## 連線測試
```
curl https://www.google.com| iconv -f iso8859-1 -t utf-8 > index.html
```
## 下載套件
```
cd ~/
git clone https://github.com/c00cjz00/f1.git
```
