```bash
conda create -n nvflare python=3.10
conda activate nvflare 
pip install nvflare
mkdir -p ~/nvflare
cd ~/nvflare

git clone https://github.com/NVIDIA/NVFlare.git
git clone --branch 2.3 https://github.com/NVIDIA/NVFlare.git NVFlare-2.3

rm -rf ./poc
mkdir -p ./poc/project/prod_00
nvflare config -pw ./poc -jt  ./NVFlare/job_templates -d ./poc/project/prod_00
cat ~/.nvflare/config.conf


nvflare stop
echo 'y' | nvflare poc prepare -n 2

nvflare poc start -ex admin@nvidia.com

nvflare job submit -j ./NVFlare-2.3/examples/hello-world/hello-numpy-cross-val/jobs/hello-numpy-cross-val
nvflare poc start -p admin@nvidia.com

```
