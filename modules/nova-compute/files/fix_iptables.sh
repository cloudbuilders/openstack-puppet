#!/usr/bin/env bash

function ip_insert {
  if ! iptables -S | grep "$1"; then
    iptables -I $1
  fi
}

ip_insert "FORWARD -s 10.65.0.0/16 -j ACCEPT"
ip_insert "FORWARD -s 172.31.0.0/16 -j ACCEPT"