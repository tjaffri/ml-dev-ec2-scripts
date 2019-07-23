sudo apt-get update --yes

############ pip and git
sudo ln -sfn /usr/bin/python3.6 /usr/bin/python
sudo apt-get install python3-pip --yes
sudo ln -sfn /usr/bin/pip3 /usr/bin/pip
sudo apt-get upgrade git --yes
sudo apt-get install git-lfs --yes
git lfs install --skip-smudge

############ docker
sudo apt-get install --yes \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update --yes
sudo apt-get install docker-ce --yes

sudo usermod -a -G docker $USER

############ nvidia-docker

# If you have nvidia-docker 1.0 installed: we need to remove it and all existing GPU containers
docker volume ls -q -f driver=nvidia-docker | xargs -r -I{} -n1 docker ps -q -a -f volume={} | xargs -r docker rm -f
sudo apt-get purge -y nvidia-docker

# Add the package repositories
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update --yes

# Install nvidia-docker2 and reload the Docker daemon configuration
DOCKER_CE_VERSION=`apt-cache show nvidia-docker2 | grep -Po "(?<=docker-ce \(= )([^)]*)" | head -n 1`
sudo apt-get -yq --allow-downgrades install nvidia-docker2 docker-ce=${DOCKER_CE_VERSION}

sudo pkill -SIGHUP dockerd

# Test nvidia-smi with the latest official CUDA image
docker run --runtime=nvidia --rm nvidia/cuda:9.0-base nvidia-smi

############ dotnetsdk
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-bionic-prod bionic main" > /etc/apt/sources.list.d/dotnetdev.list'

sudo apt-get install apt-transport-https --yes
sudo apt-get update --yes
sudo apt-get install dotnet-sdk-2.2 --yes

############ node.js
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs

############ agent extract and setup
cd ~
wget https://vstsagentpackage.azureedge.net/agent/2.149.2/vsts-agent-linux-x64-2.149.2.tar.gz
mkdir myagent && cd myagent
tar -xzf ../vsts-agent-linux-x64-2.149.2.tar.gz
./config.sh # requires input
sudo ./svc.sh install
sudo ./svc.sh start
