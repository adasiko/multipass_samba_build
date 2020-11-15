#!/bin/bash

sudo sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get -y install devscripts
sudo apt-get -y build-dep samba
sudo apt-get install -y libtracker-miner-2.0-dev libtracker-sparql-2.0-dev

export DEBEMAIL=adasiko256@yandex.com

apt-get source samba
cd samba-4.11.6+dfsg
mv ../0001-add-spotlight-support.patch ./debian/patches/

git apply debian/patches/0001-add-spotlight-support.patch
debchange -i "add spotlight support"

debuild -us -uc -i -I

cd ..
cp *.deb ./release

