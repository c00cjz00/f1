### 0. 建立 Proxy 對外連線

```bash!
ssh -fND ${HOSTNAME}:12345 intgpn01
export http_proxy="socks5://${HOSTNAME}:12345"
export https_proxy="socks5://${HOSTNAME}:12345" 
```

### 1. 安裝 goofys 

```bash!
curl -sL https://github.com/kahing/goofys/releases/latest/download/goofys > ~/goofys
chmod 755 ~/goofys

### 2. 建立帳號密碼

```bash!
mkdir ~/.aws
vi ~/.aws/credentials
```

[lab01]
aws_access_key_id = x
aws_secret_access_key =  x
```

### 3. 建立掛載目錄

```bash!
mkdir ~/lab01
```

### 4. 掛載檔案
```bash!
~/goofys  --profile lab01 --endpoint https://s3-cloud.nchc.org.tw hamtarou ~/lab01

```

### 5. 卸載
```bash!
fusermount -uz ~/lab01
```