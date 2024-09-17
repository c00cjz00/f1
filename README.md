# F1 環境設定

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
