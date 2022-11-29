#!/bin/bash
declare -a Silom_orders=("Pad thai 65" "Hoy tod 90")
declare -a Sathorn_orders=("espresso 40" "cappucino 50" "mocha 50")
declare -a Rama_9_orders=("noodle 40" "noodle jumbo 45")
declare -a Thong_Lo_orders=("krapao 65" "mukrob 70")

for i in $(seq 1 10)
do
    while true
    do
        id=$((1 + $RANDOM % 2000 ))
        if ((id >= 1 && id <= 500));
        then
            restaurant="Silom"
            break
        elif ((id >= 501 && id <= 1000))
        then
            restaurant="Sathorn"
            break
        elif ((id >= 1001 && id <= 1500))
        then
            restaurant="Rama_9"
            break
        elif ((id >= 1501 && id <= 2000))
        then
            restaurant="Thong_Lo"
            break
        else
            continue
        fi
    done
   timestamp=$(date +%s)
   echo $restaurant
    if [[ $restaurant == "Silom" ]]
    then
        
        echo "$id|${Silom_orders[$RANDOM%${#Silom_orders[@]}]}|$timestamp|OC" >> ../data/kafka/source/hdfs/order_${timestamp}.txt
    elif [[ $restaurant == "Sathorn" ]]
    then
        echo "$id|${Sathorn_orders[$RANDOM%${#Sathorn_orders[@]}]}|$timestamp|FoodST" >> ..data/kafka/source/hdfs/order_${timestamp}.txt
    elif [[ $restaurant == "Rama_9" ]]
    then
        echo "$id|${Rama_9_orders[$RANDOM%${#Rama_9_orders[@]}]}|$timestamp|WanPOS" >> ../data/kafka/source/hdfs/order_${timestamp}.txt
    else
        echo "$id|${Thong_Lo_orders[$RANDOM%${#Thong_Lo_orders[@]}]}|$timestamp|POS_THAI" >> ../data/kafka/source/hdfs/order_${timestamp}.txt
    fi
    sleep 20
done
   