#!/bin/bash

#var=3333
#var2=344
source /tmp/test/env/ww.sh

sed -i '/aaa=/d' /tmp/ttt2.conf
sed -i '/bbb=/d' /tmp/ttt2.conf
sed -i "/\[default\]/a aaa=$var" /tmp/ttt2.conf
sed -i "1 i\bbb=$var2" /tmp/ttt2.conf



exit 0
