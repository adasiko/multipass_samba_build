#!/bin/bash

multipass delete sambabuilder
multipass purge
rm -rf release
mkdir release

multipass launch --name sambabuilder --cpus 4 --mem 2G release:20.04
multipass start sambabuilder
multipass transfer 0001-add-spotlight-support.patch sambabuilder:0001-add-spotlight-support.patch
multipass transfer v_script.sh sambabuilder:v_script.sh

multipass mount release sambabuilder:/home/ubuntu/release

multipass exec sambabuilder -- chmod a+x v_script.sh
multipass exec sambabuilder -- ./v_script.sh

multipass stop sambabuilder

