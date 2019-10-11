#!/bin/bash
yum -y install wget
wget https://raw.githubusercontent.com/spikeeddington/NTI-300/master/packages.txt
for pachages in $(cat packages.txt); do
  yum -y install $packages
done
