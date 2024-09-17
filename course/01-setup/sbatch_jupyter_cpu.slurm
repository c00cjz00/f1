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
#ps aux | grep jupyter | aswk '{print $2}' | xargs kill -9
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

