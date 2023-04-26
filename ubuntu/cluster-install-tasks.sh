#!/bin/bash


###  Installing containerd  #########################

apt-get update
curl -fsSL https://get.docker.com -o get-docker.sh
sh ./get-docker.sh


###  Forwarding IPv4 and letting iptables see bridged traffic  ##############################

echo 'overlay
br_netfilter' > /etc/modules-load.d/k8s.conf
modprobe overlay
modprobe br_netfilter
echo 'net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1' > /etc/sysctl.d/20-k8s.conf
sysctl --system


###  Configuring the systemd cgroup driver  ###########################

containerd config default > /etc/containerd/config.toml
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sed -i 's/pause:3.6/pause:3.9/' /etc/containerd/config.toml
systemctl restart containerd


###  Installing kubeadm, kubelet and kubectl  ##########################

curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet kubeadm kubectl

