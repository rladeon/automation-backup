#!/bin/bash
bp="/home/rudi"
year=$(date +%Y)
month=$(date +%m)
today=$(date +%Y-%m-%d)
time_stamp=$(date +%s)
error_time=${today}'-'$(date +%H:%M:%S)

 makedirectory(){
   path=$1
   mkdir -p ${path}
   echo ${path}
   status=$?
   if [ ${status} -ne 0 ]
   then
	echo  $2 >> ${bp}/error.log
	echo "mkdir failed to create this path: $path. Status: $status" >> ${bp}/error.log
   fi
}
path="${bp}/${year}/${month}/${today}";

if [ ! -d ${path} ]
then 
	makedirectory ${path} ${error_time}
fi

wget -o /home/rudi/all.log -O ${bp}/${year}/${month}/${today}/${time_stamp}.pdf http://www.rudi-ladeon.fr/pdf/cv_math.pdf
wget_ret=$?
if [ ${wget_ret} -ne 0 ]
then
	echo -n "Error: wget failed to download the data. Status: ${wget_ret}" >> /home/rudi/error.log
        echo  "" >> ${bp}/error.log
	cat ${bp}/all.log >> ${bp}/error.log
fi
