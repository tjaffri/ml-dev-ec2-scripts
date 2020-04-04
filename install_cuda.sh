set -e

CUDA_REPO_PKG=cuda-repo-ubuntu1804_10.2.89-1_amd64.deb
wget -O /tmp/${CUDA_REPO_PKG} http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/${CUDA_REPO_PKG}
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo dpkg -i /tmp/${CUDA_REPO_PKG}

sudo apt-get update --yes
sudo apt-get upgrade --yes

sudo apt-get install cuda-drivers --yes
sudo apt-get install cuda --yes

############ nvidia-docker

# If you have nvidia-docker 1.0 installed: we need to remove it and all existing GPU containers
docker volume ls -q -f driver=nvidia-docker | xargs -r -I{} -n1 docker ps -q -a -f volume={} | xargs -r docker rm -f
sudo apt-get purge -y nvidia-docker

# Add the package repositories
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# install docker
sudo apt-get update --yes
sudo apt-get install -yq --allow-downgrades docker-ce

# Install nvidia-docker2 and reload the Docker daemon configuration
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
 sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
 sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo pkill -SIGHUP dockerd

# allow non-sudo access to docker
sudo usermod -aG docker $USER
echo "signing out and signing in...type \"exit\" to continue to test using nvidia-smi"
sudo su - $USER

# Test nvidia-smi with the latest official CUDA image
docker run --runtime=nvidia --rm nvidia/cuda:9.0-base nvidia-smi

echo "**** if the above NVIDIA-SMI output shows your GPU, you are good to go!"
echo "****** restart this VM"
