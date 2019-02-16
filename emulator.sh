#!/bin/bash
echo "Going to the sdk folder"
cd /Users/estefania.fernandez/Library/Android/sdk/emulator {CHANGE THIS}
 
echo "Emulator List:"
OUTPUT="$(./emulator -list-avds)"
echo $OUTPUT
COUNTER=1
arr[0]="Nothing"
echo "Select Device:"
 
for l in $OUTPUT
do
    arr[$COUNTER]=$l
    echo $COUNTER.$l
    let COUNTER=COUNTER+1
done
 
read IND
 
echo "Launching: ${arr[$IND]}"
 
echo "@${arr[$IND]}"
 
./emulator "@${arr[$IND]}"