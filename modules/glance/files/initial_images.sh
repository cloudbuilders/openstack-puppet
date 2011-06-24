#!/bin/bash

wget http://images.ansolabs.com/tty.tgz -O /tmp/tty.tgz
mkdir /tmp/images
tar -C /tmp/images -zxf /tmp/tty.tgz

nova-manage image convert /tmp/images