
conda create -n nvflare python=3.10
conda activate nvflare 
pip install nvflare
mkdir -p ~/nvflare
cd ~/nvflare

rm -rf ./poc
mkdir -p ./poc/project/prod_00
cp -rf ./NVFlare/job_templates ./poc/job_templates
nvflare config -pw ./poc -jt  ./poc/job_templates -d ./poc/project/prod_00
cat ~/.nvflare/config.conf


nvflare config -pw ./poc -jt  ./poc/job_templates -d ./poc/project/prod_00
nvflare stop

echo 'y' | nvflare poc prepare -n 2
git clone https://github.com/NVIDIA/NVFlare.git
cp -rf ./NVFlare/job_templates ./poc/job_templates
nvflare poc start -ex admin@nvidia.com

nvflare poc start -p admin@nvidia.com

git clone --branch 2.3 https://github.com/NVIDIA/NVFlare.git NVFlare-2.3
nvflare job submit -j ./NVFlare-2.3/examples/hello-world/hello-numpy-cross-val/jobs/hello-numpy-cross-val
