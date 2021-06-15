#Take first 150 bytes of /dev/urandom, append to tmp file

#Take most recent temperature anisotropies of the cosmic microwave background from NASA #website, append to same file

#Calculate first 1000 digits of pi, append to same file 

#Calculate sha512sum of file and create a file of that

#Do the process again to create a second file

#Append the first file to the second file

#Calculate the sha512sum of that

#Take the first 24 bytes of it.
#Reverse them.
#Turn lower case to upper case and vice versa
#Encode with a Caesar cipher corresponding to the alphabet written backwards

#!/bin/bash

read -p "Enter a random string to be your salt $(echo "")" salt

randomness=$(cat /dev/urandom | head -c 150 > /dev/null 2>&1)
background=$(curl -s https://lambda.gsfc.nasa.gov/data/suborbital/ACT/act_v2/TotalSpectra/spectrum_ACTEplusS_148x148.dat)
pi=$(echo "scale=1000; 4*a(1)" | bc -l)

function passw0rd {
echo $randomness > tmp.txt
echo $background >> tmp.txt
echo $pi >> tmp.txt
echo "$(sha512sum tmp.txt)" > firstsum.txt
}

function passw2rd {
echo $randomness > tmp2.txt
echo $background >> tmp2.txt
echo $pi >> tmp2.txt
echo "$(sha512sum tmp2.txt)" > secondsum.txt
}

echo "Constructing your new password..."
sleep 1.5
passw0rd
passw2rd
cat firstsum.txt >> secondsum.txt
echo "$(sha512sum secondsum.txt)" > tmp4.txt
for ((k = 0; k <= 10 ; k++))
do
    echo -n "[ "
    for ((i = 0 ; i <= k; i++)); do echo -n "###"; done
    for ((j = i ; j <= 10 ; j++)); do echo -n "   "; done
    v=$((k * 10))
    echo -n " ] "
    echo -n "$v %" $'\r'
    sleep 0.05
done
echo
sleep 0.5
echo "Your new password is:"
echo "$(less tmp4.txt | head -c 25 | rev | tr abcdefghijklmnopqrstuvwxyz $(openssl rand 30| base64) | tr abcdefghijklmnopqrstuvwxyz $salt | tr -dc "A-Za-z0-9^\!@%'\"#$^" </dev/urandom | head -c 25)"

rm tmp.txt
rm tmp2.txt
rm tmp4.txt
rm firstsum.txt
rm secondsum.txt
