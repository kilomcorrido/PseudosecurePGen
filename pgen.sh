## A pointlessly convoluted script to generate a password based on sha512 checksums and substitution ciphers. 
## Makes you feel secure without making you actually secure! Which I think we all agree is the best kind of security.

#!/bin/bash

read -p "Enter a random string to be your salt $(echo "")" salt

randomness=$(cat /dev/urandom | head -c 150)
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

passw0rd
passw2rd
cat firstsum.txt >> secondsum.txt
echo "$(sha512sum secondsum.txt)" > tmp4.txt 
echo ""
echo -ne "."
sleep 1
echo -ne "."
sleep 0.7
echo -ne "."
sleep 0.5
echo -ne "."
sleep 1
echo -ne "."
echo -e "\n"
echo "The following is your new password:"
echo "$(less tmp4.txt | head -c 25 | rev | tr abcdefghijklmnopqrstuvwxyz $(openssl rand 30| base64) | tr abcdefghijklmnopqrstuvwxyz $salt | tr -dc "A-Za-z0-9^\!@%'\"#$^" </dev/urandom | head -c 25)"

rm tmp.txt
rm tmp2.txt
rm tmp4.txt
rm firstsum.txt
rm secondsum.txt
