#!/bin/bash

kali_o=0
vpn_o=0
sliver_o=0

while getopts 'kvs' flag; do
  case "${flag}" in
    k) kali_o=1 ;;
    v) vpn_o=1 ;;
    s) sliver_o=1 ;;
  esac
done

POD=$(kubectl -n htb get pods | grep Running | grep -v dns | awk '{print $1}')

echo "Found pod $POD"

kali(){
kubectl -n htb exec -it $POD -- zsh
}

vpn(){
kubectl -n htb exec $POD -c opanvpn -- service danted start
}

sliver(){
    echo "Running sliver"
    folder=".htb"
    container="c2"
    sliver_path="/sliver/$folder/sliver"
    kali_path="/root/$folder/sliver"
    ip=$(kubectl -n htb get service | grep proxy | awk '{print $3}')
    port=31337

    kubectl -n htb exec $POD -- rm "$kali_path/oonray.cfg"
    kubectl -n htb exec $POD -- rm "/root/.sliver-client/configs/oonray_$ip.cfg"
    kubectl -n htb exec $POD -c $container -- /opt/sliver-server operator -n oonray -l $ip -p $port -s "$sliver_path/oonray.cfg"
    kubectl -n htb exec $POD -- sliver-client import "$kali_path/oonray.cfg"
    kubectl -n htb exec $POD -it -- sliver-client
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
