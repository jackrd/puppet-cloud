#!/bin/bash


PV_Dev_Array=( "$@" )

for ((i = 1; i < ${#PV_Dev_Array[@]}; i++))
do
    PV_Dev=${PV_Dev_Array[$i]}
	if [ $i -eq 1 ];then
		blocks+=\'
	fi
	
	blocks+=\\\"a\\\/$PV_Dev\\\/\\\"
	
	if [ $i -le $(( ${#PV_Dev_Array[@]}-2 )) ];then
		blocks+=,
	fi
done
	blocks+=\'
echo $blocks >> /tmp/qqqqq
#echo "${ARGS[@]}" &>> /tmp/qqqqq
exit 0 
