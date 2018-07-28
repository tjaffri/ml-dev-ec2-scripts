# Machine Learning Dev EC2 Linux Setup
Quick way to consistently set up and connect to an ec2 linux instance with my personal dev preferences for Machine Learning.

> **_Assumes Deep Learning AMI (base) ia installed on the ec2 instance as documented [here](https://aws.amazon.com/blogs/machine-learning/get-started-with-deep-learning-using-the-aws-deep-learning-ami/)._**

# SSH to an Instance

1. First start the instance using the AWS EC2 Console
2. Note the Public DNS (IPv4) for the instance as listed in the AWS EC2 Console
3. Run ``chmod 400 /path/my-key-pair.pem``
4. Run ``ssh -i /path/my-key-pair.pem ubuntu@ec2-198-51-100-1.compute-1.amazonaws.com``
5. To disconnect, run ``exit``

# Editing Remote Files

# Running Long-Running Tasks

# Initial Setup (One Time)

1. To set up the ``python`` alias to point to ``python3``, run ``echo "alias python=python3" >> .bash_profile``

# System Maintenance (Period)

1. Update list of available packages: ``sudo apt update --yes``
2. Upgrade packages: ``sudo apt upgrade --yes``

