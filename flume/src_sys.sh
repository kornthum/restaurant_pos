#!/bin/bash
declare -a Deccan_Pavilion_orders=("Pad thai 65" "Hoy tod 90")
declare -a Bansi_Vihar_orders=("espresso 40" "cappucino 50" "mocha 50")
declare -a Delhi_Highway_orders=("noodle 40" "noodle jumbo 45")
declare -a The_Rajput_Room_orders=("krapao 65" "mukrob 70")

for i in $(seq 1 10)
do
    while true
    do
        id=$((1 + $RANDOM % 2000 ))
        if ((id >= 1 && id <= 500));
        then
            restaurant="Deccan Pavilion"
            break
        elif ((id >= 501 && id <= 1000))
        then
            restaurant="Bansi Vihar"
            break
        elif ((id >= 1001 && id <= 1500))
        then
            restaurant="Delhi Highway"
            break
        elif ((id >= 1501 && id <= 2000))
        then
            restaurant="The Rajput Room"
            break
        else
            continue
        fi
    done
   timestamp=$(date +%s)
   echo $restaurant
    if [[ $restaurant == "Deccan Pavilion" ]]
    then
        echo "$id|$restaurant|${Deccan_Pavilion_orders[$RANDOM%${#Deccan_Pavilion_orders[@]}]}|$timestamp|OC" >> /source/hdfs/order_${timestamp}.txt
    elif [[ $restaurant == "Bansi Vihar" ]]
    then
        echo "$id|$restaurant|${Bansi_Vihar_orders[$RANDOM%${#Bansi_Vihar_orders[@]}]}|$timestamp|FoodST" >> /source/hdfs/order_${timestamp}.txt
    elif [[ $restaurant == "Delhi Highway" ]]
    then
        echo "$id|$restaurant|${Delhi_Highway_orders[$RANDOM%${#Delhi_Highway_orders[@]}]}|$timestamp|WanPOS" >>/source/hdfs/order_${timestamp}.txt
    else
        echo "$id|$restaurant|${The_Rajput_Room_orders[$RANDOM%${#The_Rajput_Room_orders[@]}]}|$timestamp|POS_THAI" >> /source/hdfs/order_${timestamp}.txt
    fi
    sleep 30
done
   