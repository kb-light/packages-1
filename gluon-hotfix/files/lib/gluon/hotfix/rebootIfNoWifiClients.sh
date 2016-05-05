#!/bin/sh

L2MESH=$(/usr/sbin/brctl show | sed -n -e '/^br-client[[:space:]]/,/^\S/ { /^\(br-client[[:space:]]\|\t\)/s/^.*\t//p }' | grep -v bat0 | tr '\n' ' ')

CLIENT_MACS=""
for if in $L2MESH; do
  CLIENT_MACS=`iw dev $if station dump | grep ^Station | cut -d ' ' -f 2`
done

clients=0
for client in $CLIENT_MACS; do
        clients=`expr $i + 1`
    done
unset CLIENT_MACS SEDDEV

if [ "$clients" -eq "0" ]; then
  reboot -f
fi