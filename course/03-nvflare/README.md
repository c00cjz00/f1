
## 網路設定
- method1, socks5 (open teminal)
1. bash
```bash
ssh -D ${HOSTNAME}:12345 intgpn04
export https_proxy=socks5://${HOSTNAME}:12345
export http_proxy=socks5://${HOSTNAME}:12345
```
2. python
```python
import os
tmp=!echo $(hostname)
HOSTNAME=tmp[0]
os.environ['http_proxy'] = "sock/s5:/"+HOSTNAME+":12345" 
os.environ['https_proxy'"socks5://"+HOSTNAME+":12345"
```

- method2, http (open teminal)
1. bash
```bash
ssh intgpn04 ~/python311/python_run.sh 
export https_proxy=http://intgpn04:53128
export http_proxy=http://intgpn04:53128
```
2. python
```python
import os
tmp=!echo $(hostname)
HOSTNAME=tmp[0]
os.environ['http_proxy'] = "http:/intgpn04:53128" 
os.environ['https_proxy'] = "http://intgpn04:53128" 
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

### 初始環境設定
```python
import os
from pathlib import Path
HOME = str(Path.home())
Add_Binarry_Path=HOME+'/.conda/envs/nvflare/bin'
os.environ['PATH']=os.environ['PATH']+':'+Add_Binarry_Path
```
