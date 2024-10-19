my_fed_learn_port=80
my_admin_port=8003
git clone --branch 2.3 https://github.com/NVIDIA/NVFlare.git NVFlare-2.3

docker stop nvflare
docker rm nvflare

mkdir -p workspace

cp google.yml workspace/project.yml
sed -i "s#my_fed_learn_port#${my_fed_learn_port}#g" workspace/project.yml
sed -i "s#my_admin_port#${my_admin_port}#g" workspace/project.yml
sed -i "s#my_ip#$(curl ifconfig.me)#g" workspace/project.yml

docker run -d --name nvflare -v ./workspace:/workspace -v ./NVFlare-2.3:/NVFlare -p 80:80 -p 8003:8003 nvflare/nvflare sleep infinity

docker exec nvflare bash -c "cd /workspace; rm -rf poc; nvflare provision -p project.yml -w poc; cp -rf /NVFlare/examples/hello-world/hello-numpy-sag/jobs/hello-numpy-sag /workspace/poc/example_project/prod_00/admin@nvidia.com/transfer/"
rm workspace.zip 
zip -r workspace.zip workspace/

docker exec nvflare bash -c "cd /workspace/poc/example_project/prod_00/$(curl ifconfig.me); rm daemon_pid.fl; echo y | ./startup/stop_fl.sh; sleep 15; ./startup/sub_start.sh"

# docker exec -it nvflare bash
# cd /workspace/poc/example_project/prod_00/admin\@nvidia.com/startup
# ./fl_admin.sh