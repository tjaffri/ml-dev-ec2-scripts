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
wget https://vstsagentpackage.azureedge.net/agent/2.165.2/vsts-agent-linux-x64-2.165.2.tar.gz
mkdir myagent && cd myagent
tar -xzf ../vsts-agent-linux-x64-2.165.2.tar.gz
./config.sh # requires input
sudo ./svc.sh install
sudo ./svc.sh start
