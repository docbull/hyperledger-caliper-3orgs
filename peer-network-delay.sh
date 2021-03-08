#!/bin/bash

# Dongguk Univ, Gyeon-ju Campus., INLab
# REF) https://wahabjawed.medium.com/extending-hyperledger-fabric-network-adding-a-new-peer-4f52f70a7217

# shell script for invoking issue transactions

echo
echo "random network delay setup"
SEQUENCE=$(seq 1 25)

NET_DELAY=("21ms" "28ms" "18ms" "24ms" "15ms" "43ms" "38ms" "43ms" "37ms" "40ms" "10ms" "39ms" "50ms" "28ms" "13ms" "44ms" "37ms" "44ms" "15ms" "15ms" "33ms" "13ms" "30ms" "25ms" "24ms")

PEER1="172.28.0.32"
PEER2="172.28.0.39"
PEER5="172.28.0.54"
PEER6="172.28.0.57"
PEER12="172.28.0.56"
PEER13="172.28.0.50"
PEER14="172.28.0.43"
PEER15="172.28.0.55"
PEER16="172.28.0.42"
PEER17="172.28.0.38"
PEER21="172.28.0.35"
PEER22="172.28.0.41"

for i in $SEQUENCE
do
    echo "Peer #${i}"
    #docker exec peer${i}.org1.example.com tc qdisc del dev eth0 root
    docker exec peer${i}.org1.example.com tc qdisc add dev eth0 root netem delay ${NET_DELAY[$i-1]}
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