#!/bin/bash

kali_o=0
vpn_o=0
sliver_o=0
start_o=0
space_n="htb"

while getopts 'kvstn' flag; do
  case "${flag}" in
    k) kali_o=1 ;;
    v) vpn_o=1 ;;
    s) sliver_o=1 ;;
    t) start_o=1;;
    n) space_n=$OPTARG
  esac
done

POD=$(kubectl -n $space_n get pods | grep Running | grep -v dns | awk '{print $1}')

echo "Found pod $POD"

kali(){
kubectl -n $space_n exec -it $POD -c kali -- zsh
}

vpn(){
kubectl -n $space_n exec $POD -c openvpn -- service danted start
}

sliver(){
    echo "Running sliver"
    folder=".htb"
    container="c2"
    sliver_path="/home/sliver/$folder/sliver"
    kali_path="/root/$folder/sliver"
    ip="proxy.$space_n.svc.cluster.local"
    port=31337

    kubectl -n $space_n exec $POD -- rm "$kali_path/oonray.cfg"
    kubectl -n $space_n exec $POD -- rm "/root/.sliver-client/configs/oonray_$ip.cfg"
    kubectl -n $space_n exec $POD -c $container -- /opt/sliver-server operator -n oonray -l $ip -p $port -s "$sliver_path/oonray.cfg"
    kubectl -n $space_n exec $POD -- sliver-client import "$kali_path/oonray.cfg"
    kubectl -n $space_n exec $POD -it -- sliver-client
}

empire(){
    echo "Running EMpire"
}

msf(){
    echo "Running MSF"
}

start(){
 vpn
 kali
}

if [ "$kali_o" -eq 1 ]
then
    kali
fi

if [ "$vpn_o" -eq 1 ]
then
    vpn
fi

if [ "$sliver_o" -eq 1 ]
then
    sliver
fi

if [ "$start_o" -eq 1 ]
then
    start
fi
