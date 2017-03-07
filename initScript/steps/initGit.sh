#!/bin/bash
cd /initENV/initSoftwares
tar -zxvf git-2.0.1.tar.gz -C /wsworkenv

cd /wsworkenv
mv git-2.0.1 git

yes Y | yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel gcc perl-ExtUtils-MakeMaker 

cd git
make prefix=/wsworkenv/git all
make prefix=/wsworkenv/git install
echo "export PATH=\$PATH:/wsworkenv/git/bin" >> /etc/profile
source /etc/profile

git config --global user.name "twoplus_studio"
git config --global user.email "twoplus_studio@163.com"
