#!/snap/bin/pwsh

param ([Switch]$kali,
       [Switch]$proxy,
       [Switch]$sliver)

$Pod = (kubectl -n htb get pod | Select-String kali).ToString().Split()[0]

function start_kali(){
    kubectl -n htb exec -it $Pod -- zsh
}

function start_vpn(){
  kubectl -n htb exec $Pod -c openvpn -- service danted start
}

function start_sliver(){
    $sliver_path='/sliver/.pk/sliver'
    $kali_path="/root/.pk/sliver"

    $ip = (kubectl -n htb get service | Select-String proxy).ToString().Split()[6]
    $port = 31337

    Write-Host "$ip"
    Write-Host "$port"

    kubectl -n htb exec $Pod -- rm "$kali_path/oonray.cfg"
    kubectl -n htb exec $Pod -- rm "/root/.sliver-client/configs/oonray_$ip.cfg"
    kubectl -n htb exec $Pod -c sliver -- /opt/sliver-server operator -n oonray -l $ip -p $port -s "$sliver_path/oonray.cfg"
    kubectl -n htb exec $Pod -- sliver-client import "$kali_path/oonray.cfg"
    kubectl -n htb exec $Pod -it -- sliver-client
}

if($proxy){
    start_vpn
}

if(($sliver) -and ($kali)){
    write-host "Cannot start both kali and sliver"
    exit
}

if($kali){
    start_kali
}

if($sliver){
    start_sliver
}
