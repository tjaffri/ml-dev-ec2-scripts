# Machine Learning Dev EC2 Linux Setup
Quick way to consistently set up and connect to an ec2 linux instance with my personal dev preferences for Machine Learning.

> **_Assumes Deep Learning AMI (full, NOT base) is installed on the ec2 instance as documented [here](https://aws.amazon.com/blogs/machine-learning/get-started-with-deep-learning-using-the-aws-deep-learning-ami/)._**

# SSH to an Instance

1. First start the instance using the AWS EC2 Console
2. Note the Public DNS (IPv4) for the instance as listed in the AWS EC2 Console
3. Run ``chmod 400 /path/my-key-pair.pem``
4. Run ``ssh -i /path/my-key-pair.pem ubuntu@ec2-198-51-100-1.compute-1.amazonaws.com``
5. To disconnect, run ``exit``

# Editing Remote Files

If you want to edit files on the remote machine you are connected to via SSH, you essentially have to use command line editors (e.g. vim). If you want to use something fancier, like vscode or sublime text you have two options:
1. Edit everything on a different machine and commit / push to git. Git pull and only run on the remote machine without any editing. For any minimal editing / config on the remote machine, get friendly with vim.
2. Set up remote vscode. This just allows you to edit a single file at a time (not an entire folder). See https://codeyarns.com/2018/05/03/how-to-edit-remote-files-using-remote-vscode/​​.
3. Use sshfs or similar tool to mount a folder on the remote ec2 machine as a local drive on MacOS. I have not tried this yet, so any PRs documenting how to do this are welcome.

# Running Long-Running Tasks
1. Run ``screen`` and initiate your long-running process
2. To detach, enter ``Ctrl-a, d`` and now you can disconnect.
3. When you reconnect, enter ``screen -r`` to reattach and continue your long-running process.
4. If more than one screens are running, you can run ``screen -ls`` to list.

# Initial Setup (One Time)

1. Set up git lfs using the steps here: https://github.com/git-lfs/git-lfs/wiki/Installation#ubuntu. Specifically, run:
    1. ``sudo apt-get install software-properties-common``
    2. ``sudo add-apt-repository ppa:git-core/ppa``
    3. ``curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash``
    4. ``sudo apt-get install git-lfs``
    5. ``git lfs install --skip-smudge``
2. Configure git username:
    1. ``git config --global user.name "Your Name"``
    2. ``git config --global user.email you@example.com``
2. Clone your repos, then make sure credentials are persisted:
    1. ``git clone https://.../foo.git``
    2. Specify username and password (ideally a single use token) to clone
    3. cd into the cloned repo dir, then run ``git config credential.helper store``
    4. Run ``git pull`` again, then specify the username and password again. This time it will be persisted.
3. Set up ``screen`` for long-running processes that keep running after SSH disconnects: ``sudo apt install screen``

# System Maintenance (Periodic)

1. Update list of available packages: ``sudo apt update --yes``
2. Upgrade packages: ``sudo apt upgrade --yes``

