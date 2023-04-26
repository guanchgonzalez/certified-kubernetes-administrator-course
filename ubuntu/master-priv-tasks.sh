#!/bin/bash


###  Initializing your control-plane node  #########################

masterId=$1
OUT=/root/$(date +%Y%m%d%H%M%S)_kubeadm_init.out
kubeadm init --pod-network-cidr 10.244.0.0/16 --apiserver-advertise-address=192.168.56.2 > ${OUT}
mkdir /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
echo '#!/bin/bash' > /home/vagrant/${masterId}_add_node.sh
tail -3 ${OUT} >> /home/vagrant/${masterId}_add_node.sh
chown -R vagrant:vagrant /home/vagrant/
mv /home/vagrant/${masterId}_add_node.sh /vagrant/ubuntu/

