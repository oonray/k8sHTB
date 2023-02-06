#!/bin/bash
set -x
k='kubectl -n htb'
pod=`$k get pod | grep kali | awk '{print $1}'`
port=`$k get service | grep -oE '31337:[0-9]{5,}' | awk -F ':' '{print $1}'`
ip=`$k get service | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`

sliver_path='/~/.pk/sliver'
kali_path="/root/.pk/sliver"

$k exec $pod -- rm "$kali_path/oonray.cfg"
$k exec $pod -- rm "/root/.sliver-client/configs/oonray_$ip.cfg"
$k exec $pod -c sliver -- /opt/sliver-server operator -n oonray -l $ip -p $port -s "$sliver_path/oonray.cfg" 
$k exec $pod -- sliver-client import "$kali_path/oonray.cfg"
$k exec $pod -it -- sliver-client
