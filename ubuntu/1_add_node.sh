#!/bin/bash

kubeadm join 192.168.56.2:6443 --token 9p6c1l.8o4a4lluv6gcwcat \
	--discovery-token-ca-cert-hash sha256:e4e3bd7933812c82503d7166c5f101178288702bd0804d2aae0c20f7a9aaba3f 
