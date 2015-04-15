#!/bin/bash

rabbit_pass=$1

echo $rabbit_pass >  /tmp/base/rabbitmqctl.txt

rabbitmqctl change_password guest $rabbit_pass &>> /tmp/base/rabbitmqctl.txt

exit 0