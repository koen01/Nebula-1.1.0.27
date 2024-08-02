#!/bin/sh

#echo "MDEV=$MDEV ; ACTION=$ACTION ; DEVPATH=$DEVPATH" > /dev/console

case "${ACTION}" in
add)
    ubus call laser set_state '{"laser_plugged": 1}'
    ;;
remove)
    ubus call laser set_state '{"laser_plugged": 0}'
    ;;
esac
