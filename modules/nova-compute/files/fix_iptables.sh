#!/usr/bin/env bash

function ip_insert {
  iptables -D $1
  iptables -I $1
}

ip_insert "FORWARD -s 10.65.0.0/16 -j ACCEPT"
ip_insert "FORWARD -s 172.31.0.0/16 -j ACCEPT"
ip_insert "FORWARD -s 192.168.0.0/16 -j ACCEPT"
