#!/bin/sh
tmp="/tmp/refresh-net.$$.log"
command() {
        st=$1
        shift
        logger -s -t "refresh network"  "$* .................."
        eval $* | tee $tmp
        logger -s -t "refresh network" -f $tmp
        logger -s -t "refresh network" "$* ...... RV: $?"
        sleep $st
}

command 0 nmcli networking off
command 3 sudo systemctl stop NetworkManager
command 0 sudo ip link set enp3s0 down
command 0 sudo modprobe -r r8169
command 0 sudo modprobe r8169
command 0 sudo ip link set enp3s0 mode DEFAULT
command 0 sudo ip link set enp3s0 up
command 3 sudo systemctl start NetworkManager
command 0 nmcli networking on
