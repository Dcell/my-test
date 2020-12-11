#!/bin/bash
rp=`echo ${@:1}`
file=$PWD/txt
echo ''$rp''
sed -i '.bak' "s/1/$rp/g" $file