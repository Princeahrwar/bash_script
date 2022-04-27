#!/bin/bash

#To check if we have 2 arguments
if [ $# != 2 ]
then
echo -e " please pass required argument while running the bash lab.sh \n first argument is an input file name, and the second one is an output file name."
exit 1
fi

#To check if inputfile exists
if [ ! -f $1 ] ;
then
echo -e "Please pass a existing and valid input file"
exit 1
fi
 
 #To print specific fields of data
 echo -e "Name PredominantDegree HighestDegree Region Geography AdmissionRate AverageCost Expenditure\n">>$2
awk '{FS=","} {OFS=" "} NR>1 {print $1,$2,$3,$5,$6,$7,$10,$11}' $1 > $2

#For the college with HighestDegree as Bachelor's
echo -e "\n\n Name of the college whose HighestDegree is Bachelor's : " >>$2
awk -v q="'" '{FS=","}$3 == "Bachelor"q"s"{ print $1}'  $1 >>$2

#To print Average admission rate according to Geography
echo -e "\n\nGeography: Average Admission Rate : ">>$2
awk '{FS=","} NR >1 {arr[$6]+=$7;count[$6]++} END{for(i in arr){print i": "arr[i]/count[i]}}' $1 >>$2

#the top five colleges who have maximum MedianEarnings.
echo -e "\n\ntop five colleges who have maximum MedianEarnings : ">>$2
sort -t, -nk16 $1|awk '{FS=","} NR>1 {print $1}'|tail -n 5  >>$2