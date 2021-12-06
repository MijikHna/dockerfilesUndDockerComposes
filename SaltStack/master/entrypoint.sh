#!/usr/bin/env bash

SALT_MASTER=1
while [ ${SALT_MASTER} != 0 ]
do
    service salt-master status
    SALT_MASTER=${?}
    if [ ${SALT_MASTER} == 0 ]; then
        echo "salt-master stared"
        break
    fi
    salt-master -l debug -d
    sleep 10
done

SALT_API=1
while [ ${SALT_API} != 0 ]
do
    service salt-api status
    SALT_API=${?}
    if [ ${SALT_API} == 0 ]; then
        echo "salt-api stared"
        break
    fi
    salt-api -l debug -d
    sleep 5
    echo "salt-api not started with salt-master"
done

SALT_KEY_L_RESPONSE=1
while [ ${SALT_KEY_L_RESPONSE} != 0 ]
do
    salt-key -L | grep 'salt-minion'
    SALT_KEY_L_RESPONSE=${?}
    echo "salt-key-res -L: ${SALT_KEY_L_RESPONSE}"
    if [ ${SALT_KEY_L_RESPONSE} == 0 ]; then
        break
    fi
    sleep 5
done

sleep 5

yes | salt-key -A
echo "salt-minion accepted"

tail -f /var/log/salt/master