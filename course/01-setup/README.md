# F1 教學 (I) 系統安裝與操作
https://man.twcc.ai/@f1-manual/manual
## 登入與設定操作教學
- **iService(註冊/查詢) 和 HFS 變更計畫設定(綁定/異動/可用空間)**
https://man.twcc.ai/@f1-manual/iService
```
# # Login node (URL)
iservice.nchc.org.tw
```
- **登入節點操作流程**
https://man.twcc.ai/@f1-manual/login_node
```
# Login node (SSH)
f1-ilgn01.nchc.org.tw
```
- **儲存資源與目錄位置**
https://man.twcc.ai/@f1-manual/BJCsa5RSA
```
# disk check
/usr/lpp/mmfs/bin/mmlsquota -u xxxxx --block-size auto home1 work1
# user quota
/home	100 GB
/work	100 GB #國科會計畫可增及到1.5T
```
- **檔案傳輸節點**
https://man.twcc.ai/@f1-manual/transport_ip
```
# Login node (SFTP)
sftp <unix_account>@f1-dtn-vip.nchc.org.tw。
```
- **互動式繪圖節點操作流程**
https://man.twcc.ai/@f1-manual/thinlinc
```
# Login node (互動節點)
f1-intgpn01.nchc.org.tw	
```

- **特殊工作節點操作流程**
https://f1-stn01.nchc.org.tw/ or https://f1-stn02.nchc.org.tw/
1. Application – Code Server
https://f1-stn02.nchc.org.tw/pun/sys/dashboard
2. Application – Jupyter Lab
https://f1-stn02.nchc.org.tw/pun/sys/dashboard
3. Application – Job Composer
https://f1-stn02.nchc.org.tw/pun/sys/dashboard/apps/show/myjobs

工作範例: 
```bash
#!/bin/bash
#SBATCH --account=GOV113077           # (-A) iService Project ID
#SBATCH --job-name=sleep              # (-J) Job name
#SBATCH --partition=ct112             # (-p) Slurm partition
#SBATCH --nodes=1                     # (-N) Maximum number of nodes to be allocated
#SBATCH --cpus-per-task=2             # (-c) Number of cores per MPI task
#SBATCH --ntasks-per-node=1           # Maximum number of tasks on each node
##SBATCH --time=4-00:00:00            # (-t) Wall time limit (days-hrs:min:sec)
#SBATCH --output=job-%j.out           # (-o) Path to the standard output file
#SBATCH --error=job-%j.err            # (-e) Path to the standard error file
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=summerhill001@gmail.com  	# Where to send mail.  Set this to your email address

#bash -c "sleep infinity" 
## jupyter-lab password
#ps aux | grep jupyter | awk '{print $2}' | xargs kill -9
#sleep 3
#myport=30001
#myport=$(python3 port.py)
myport=$(python3 -c "import socket; s = socket.socket(socket.AF_INET, socket.SOCK_STREAM); s.bind(('', 0)) ;addr = s.getsockname(); print(addr[1]); s.close();")
myhostname=$(hostname -s)
ml tools/miniconda3
ml tools/jupyterlab
jupyter-lab --notebook-dir=/home/$(whoami) --no-browser --ip=${myhostname} --port=${myport} \
--NotebookApp.base_url /node/${myhostname}/${myport} --NotebookApp.allow_remote_access true > ./jupyter.log 2>&1 &
## Get pid
pid=$!
echo https://f1-stn02.nchc.org.tw/node/${myhostname}/${myport}/lab/ > ./links.txt
echo "pid=$pid"
echo "Wait for pid....."
sleep 2
wait $pid
```

## Jupyter notebook 服務
### 新增網路連線
1. SSHPROXY (模式一, 於登入節點ilgn01啟動)
```bash
ssh -D ilgn01:12345 ilgn01
```
2. 環境變數
```bash
export http_proxy="socks5://ilgn01:12345"
echo export https_proxy="socks5://ilgn01:12345"
```
```python
import os
os.environ['http_proxy'] = "socks5://ilgn01:12345" 
os.environ['https_proxy'] = "socks5://ilgn01:12345" 
```

3. SSHPROXY (模式二, 於計算節點連線至登入節點intgpn01啟動)
```bash!
ssh -fND ${HOSTNAME}:12345 intgpn01
```
4. 環境變數
```bash
export http_proxy="socks5://${HOSTNAME}:12345"
export https_proxy="socks5://${HOSTNAME}:12345"
```
```python!
import os
tmp=!echo $(hostname)
HOSTNAME=tmp[0]
os.environ['http_proxy'] = "socks5:/"+HOSTNAME+":12345" 
os.environ['https_proxy'] = "socks5://"+HOSTNAME+":12345" 
```

### singularity image ipykernel (Image內建python)
1. 建立 singularity image kernel 
請於 notebok 右上角顯示 ***kernel=[python3]*** 狀況下執行以下cell內容
```bash
%%bash
IMAGE=/work1/c00cjz00/f1/docker/metagenome_2024.5.sif
IMAGE_basename=$(basename "$IMAGE" .sif)
IPYKERNEL=/work1/c00cjz00/f1/ipykernel/image_with_ipykernel
mkdir -p /home/$(whoami)/.local/share/jupyter/kernels/
rm -rf /home/$(whoami)/.local/share/jupyter/kernels/${IMAGE_basename}
cp -rf ${IPYKERNEL} /home/$(whoami)/.local/share/jupyter/kernels/${IMAGE_basename}
chmod -R 755 /home/$(whoami)/.local/share/jupyter/kernels/${IMAGE_basename}
IMAGE_desc=$(echo $IMAGE | sed 's_/_\\/_g')
sed -i "s/templateSIF/${IMAGE_desc}/g" /home/$(whoami)/.local/share/jupyter/kernels/${IMAGE_basename}/kernel.json
sed -i "s/templateImage/Image_${IMAGE_basename}/g" /home/$(whoami)/.local/share/jupyter/kernels/${IMAGE_basename}/kernel.json
# 若你的映像檔案有python套件但沒有pip套件, 請安裝以下兩項
#curl https://bootstrap.pypa.io/get-pip.py -o  ~/get-pip.py
#singularity exec $IMAGE python ~/get-pip.py
# 若你的映像檔案有python, pip套件, 請安裝以下一項
#singularity exec ${IMAGE} pip install ipykernel
```
2. 啟動初始環境設定
請於 notebok 右上角顯示 ***kernel=[你的IMAGE名稱]*** 狀況下執行以下cell內容
```python
import os
from pathlib import Path
HOME = str(Path.home())
Add_Binarry_Path=HOME+'/.local/bin:/usr/localbin'
os.environ['PATH']=os.environ['PATH']+':'+Add_Binarry_Path
```
3. 啟動套件計算
請於 notebok 右上角顯示 ***kernel=[你的IMAGE名稱]*** 狀況下執行以下cell內容
```bash
!qiime
```
4. IPYKERNEL=/work1/c00cjz00/f1/ipykernel/image_with_ipykernel 內容介紹
> 目錄檔案
```
kernel.json
logo-32x32.png
logo-64x64.png
```
> kernel.json
```json
{
 "language": "python",
 "argv": ["singularity",
   "exec",
   "--cleanenv",
   "-B",
   "/work1:/work",
   "-B",
   "/usr/bin:/usr/localbin",     
   "templateSIF",
   "python3",
   "-m",
   "ipykernel",
   "-f",
   "{connection_file}"
 ],
 "display_name": "templateImage"
}
```
### singularity image ipykernel (Image沒有python)
1. 建立 singularity image kernel 
請於 notebok 右上角顯示 ***kernel=[python3]*** 狀況下執行以下cell內容
```bash
%%bash
IMAGE=/work1/c00cjz00/f1/docker/humann_latest.sif
IMAGE_basename=$(basename "$IMAGE" .sif)
IPYKERNEL=/work1/c00cjz00/f1/ipykernel/image_without_ipykernel
mkdir -p /home/$(whoami)/.local/share/jupyter/kernels/
rm -rf /home/$(whoami)/.local/share/jupyter/kernels/${IMAGE_basename}
cp -rf ${IPYKERNEL} /home/$(whoami)/.local/share/jupyter/kernels/${IMAGE_basename}
chmod -R 755 /home/$(whoami)/.local/share/jupyter/kernels/${IMAGE_basename}
IMAGE_desc=$(echo $IMAGE | sed 's_/_\\/_g')
sed -i "s/templateSIF/${IMAGE_desc}/g" /home/$(whoami)/.local/share/jupyter/kernels/${IMAGE_basename}/kernel.json
sed -i "s/templateImage/Image_${IMAGE_basename}/g" /home/$(whoami)/.local/share/jupyter/kernels/${IMAGE_basename}/kernel.json
singularity exec -B /pkg/tools/miniconda3 ${IMAGE} /pkg/tools/miniconda3/bin/pip install ipykernel -q
```
2. 啟動初始環境設定
請於 notebok 右上角顯示 ***kernel=[你的IMAGE名稱]*** 狀況下執行以下cell內容
```python
import os
from pathlib import Path
HOME = str(Path.home())
Add_Binarry_Path=HOME+'/.local/bin:/usr/localbin'
os.environ['PATH']=os.environ['PATH']+':'+Add_Binarry_Path
```
3. 啟動套件計算
請於 notebok 右上角顯示 ***kernel=[你的IMAGE名稱]*** 狀況下執行以下cell內容
```bash
!qiime
```
4. IPYKERNEL=/work1/c00cjz00/f1/ipykernel/image_without_ipykernel 內容介紹
> 目錄檔案
```
kernel.json
logo-32x32.png
logo-64x64.png
```
> kernel.json
```json
{
 "language": "python",
 "argv": ["singularity",
   "exec",
   "--cleanenv",   
   "-B",
   "/work1:/work",
   "-B",
   "/usr/bin:/usr/localbin",
   "-B",
   "/pkg/tools/miniconda3",
   "templateSIF",
   "/pkg/tools/miniconda3/bin/python",
   "-m",
   "ipykernel",
   "-f",
   "{connection_file}"
 ],
 "display_name": "templateImage"
}
```

## 操作 Modules
https://man.twcc.ai/@f1-manual/modules_instructions
| 指令 | 說明 | 
| -------- | -------- |
| module avail     | 列出可使用的 modules     | 
| module list	| 列出已套用的 modules| 
| module load/add package1 package2 …| 	套用指定的module| 
| module unload/del/rm package1| 	移除讀取的模組設定| 

## 操作 Slurm Job
1. [Slurm簡介](https://man.twcc.ai/@f1-manual/slurm_instructions)
2. [Slurm佇列 (Partition)](https://man.twcc.ai/@f1-manual/partition)
3. [分配工作(Job)資源](https://man.twcc.ai/@f1-manual/slurm_job_resource)
4. [提交與管理Job的範例](https://man.twcc.ai/@f1-manual/slurm_job_example)
