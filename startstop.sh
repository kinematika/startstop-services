#!/bin/bash
options="$1"
services="httpd.service postgrespro-std-14.service nginx.service"
#Если при запуске скрипта не указан параметр, то работа скрипта будет завершена
if [ -z "$options" ]; then
    echo "Enter options start, stop or restart. Example ./startstop.sh stop"
    exit
fi

for unit in $services
do
    check="$(systemctl list-unit-files $unit | awk '{ print $1 }' | grep $unit)"
    if [ "$unit" == "$check" ]
    then
    sleep 5
    systemctl "$options" "$unit"
    state="$(systemctl show -p ActiveState $unit | sed 's/ActiveState=//g')"
    echo "$options" "$unit - status: $state"
else
    sleep 5
    echo "$unit not found"
fi
done
