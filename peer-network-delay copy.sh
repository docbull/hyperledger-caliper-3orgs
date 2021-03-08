#!/bin/bash

# Dongguk Univ, Gyeon-ju Campus., INLab
# REF) https://wahabjawed.medium.com/extending-hyperledger-fabric-network-adding-a-new-peer-4f52f70a7217

# shell script for invoking issue transactions

echo
echo "random network delay setup"
SEQUENCE=$(seq 1 25)

NET_DELAY=("21ms" "28ms" "18ms" "24ms" "15ms" "43ms" "38ms" "43ms" "37ms" "40ms" "10ms" "39ms" "50ms" "28ms" "13ms" "44ms" "37ms" "44ms" "15ms" "15ms" "33ms" "13ms" "30ms" "25ms" "24ms")

PEER1="192.168.144.43"
PEER2="192.168.144.57"
PEER5="192.168.144.41"
PEER6="192.168.144.42"
PEER12="192.168.144.52"
PEER13="192.168.144.33"
PEER14="192.168.144.46"
PEER15="192.168.144.39"
PEER16="192.168.144.48"
PEER17="192.168.144.38"
PEER21="192.168.144.45"
PEER22="192.168.144.49"

for i in $SEQUENCE
do
    echo "Peer #${i}"
    #docker exec peer${i}.org1.example.com tc qdisc del dev eth0 root

    if [ $i -eq 1 ]
    then
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 root handle 1: htb
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 1 u32 flowid 1:1 match ip dst ${PEER2}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 2ms
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 2 u32 flowid 1:2 match ip src ${PEER1}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:2 handle 20: netem delay ${NET_DELAY[$i-1]}
    elif [ $i -eq 2 ]
    then
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 root handle 1: htb
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 1 u32 flowid 1:1 match ip dst ${PEER1}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 2ms
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 2 u32 flowid 1:2 match ip src ${PEER2}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:2 handle 20: netem delay ${NET_DELAY[$i-1]}
    elif [ $i -eq 5 ]
    then
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 root handle 1: htb
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 1 u32 flowid 1:1 match ip dst ${PEER6}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 9ms
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 2 u32 flowid 1:2 match ip src ${PEER5}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:2 handle 20: netem delay ${NET_DELAY[$i-1]}
    elif [ $i -eq 6 ]
    then
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 root handle 1: htb
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 1 u32 flowid 1:1 match ip dst ${PEER5}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 9ms
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 2 u32 flowid 1:2 match ip src ${PEER6}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:2 handle 20: netem delay ${NET_DELAY[$i-1]}
    elif [ $i -eq 14 ]
    then
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 root handle 1: htb
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 1 u32 flowid 1:1 match ip dst ${PEER12}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 5ms
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 2 u32 flowid 1:2 match ip dst ${PEER13}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:2 handle 20: netem delay 5ms
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:3 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 3 u32 flowid 1:3 match ip src ${PEER14}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:3 handle 30: netem delay ${NET_DELAY[$i-1]}
    elif [ $i -eq 12 ]
    then
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 root handle 1: htb
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 1 u32 flowid 1:1 match ip dst ${PEER14}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 5ms
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 2 u32 flowid 1:2 match ip src ${PEER12}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:2 handle 20: netem delay ${NET_DELAY[$i-1]}
    elif [ $i -eq 13 ]
    then
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 root handle 1: htb
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 1 u32 flowid 1:1 match ip dst ${PEER14}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 5ms
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 2 u32 flowid 1:2 match ip src ${PEER13}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:2 handle 20: netem delay ${NET_DELAY[$i-1]}
    elif [ $i -eq 15 ]
    then
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 root handle 1: htb
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 1 u32 flowid 1:1 match ip dst ${PEER16}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 9ms
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 2 u32 flowid 1:2 match ip dst ${PEER17}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:2 handle 20: netem delay 9ms
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:3 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 3 u32 flowid 1:3 match ip src ${PEER15}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:3 handle 30: netem delay ${NET_DELAY[$i-1]}
    elif [ $i -eq 16 ]
    then
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 root handle 1: htb
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 1 u32 flowid 1:1 match ip dst ${PEER15}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 9ms
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 2 u32 flowid 1:2 match ip src ${PEER16}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:2 handle 20: netem delay ${NET_DELAY[$i-1]}
    elif [ $i -eq 17 ]
    then
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 root handle 1: htb
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 1 u32 flowid 1:1 match ip dst ${PEER15}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 9ms
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 2 u32 flowid 1:2 match ip src ${PEER17}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:2 handle 20: netem delay ${NET_DELAY[$i-1]}
    elif [ $i -eq 21 ]
    then
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 root handle 1: htb
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 1 u32 flowid 1:1 match ip dst ${PEER22}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 2ms
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 2 u32 flowid 1:2 match ip src ${PEER21}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:2 handle 20: netem delay ${NET_DELAY[$i-1]}
    elif [ $i -eq 22 ]
    then
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 root handle 1: htb
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:1 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 1 u32 flowid 1:1 match ip dst ${PEER21}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 2ms
        docker exec peer${i}.org1.example.com tc class add dev eth0 parent 1: classid 1:2 htb rate 100mbit
        docker exec peer${i}.org1.example.com tc filter add dev eth0 parent 1: protocol ip prio 2 u32 flowid 1:2 match ip src ${PEER22}
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 parent 1:2 handle 20: netem delay ${NET_DELAY[$i-1]}
    else
        docker exec peer${i}.org1.example.com tc qdisc add dev eth0 root netem delay ${NET_DELAY[$i-1]}
    fi
done

echo "network delay have set"

#for i in $SEQUENCE
#do
#    rand=$(((RANDOM % 80) + 20))
#    NET_DELAY=${rand}
#    #NET_DELAY=60ms
#    #docker exec peer${i}.org1.example.com tc qdisc del dev eth0 root
#    docker exec peer${i}.org1.example.com tc qdisc add dev eth0 root netem delay $NET_DELAY
#    echo "$NET_DELAY"
#done