#!/bin/bash
yum -y install wget
for pachages in $(cat packages.txt); do
  yum -y install $packages
done
