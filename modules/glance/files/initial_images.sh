#!/bin/bash

sudo -u nova wget http://images.ansolabs.com/tty.tgz -O /tmp/tty.tgz
sudo -u nova mkdir /tmp/images
sudo -u nova tar -C /tmp/images -zxf /tmp/tty.tgz

sudo -u nova nova-manage image convert /tmp/images
