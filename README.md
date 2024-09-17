# f1

## SSHPROXY, 開啟終端機, 執行以下連線
```
ssh -D ${HOSTNAME}:12345 ilgn01
```
## Vash 環境變數
```
export http_proxy="socks5://${HOSTNAME}:12345"
export https_proxy="socks5://${HOSTNAME}:12345"
```
## python 環境變數
```
import os
HOSTNAME=os.environ['HOSTNAME']
os.environ['http_proxy'] = "socks5:/"+HOSTNAME+":12345" 
os.environ['https_proxy'] = "socks5://"+HOSTNAME+":12345" 
```
## 連線測試
```
!curl https://www.google.com| iconv -f iso8859-1 -t utf-8 > index.html
```
