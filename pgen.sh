#!/bin/bash

#Enter your salt
read -p "Enter a random string to be your salt. Be sure to get real freaky with it! $(echo "")" salt

#Take first 150 bytes of /dev/urandom output
randomness=$(cat /dev/urandom | head -c 150)
#Take most recent temperature anisotropies of the cosmic microwave background from NASA website, append to same file
background=$(curl https://lambda.gsfc.nasa.gov/data/suborbital/ACT/act_v2/TotalSpectra/spectrum_ACTEplusS_148x148.dat)
#Take first 1000 digits of pi
pi=$(echo "scale=1000; 4*a(1)" | bc -l)

#Calculate sha512 checksum of all those things concatenated into tmp.txt
function passw0rd {
        echo $randomness > tmp.txt
        echo $background >> tmp.txt
        echo $pi >> tmp.txt
        echo "$(sha512sum tmp.txt)" > firstsum.txt
}

#Calculate another sha512 checksum of same
function passw2rd {
        echo $randomness > tmp2.txt
        echo $background >> tmp2.txt
        echo $pi >> tmp2.txt
        echo "$(sha512sum tmp2.txt)" > secondsum.txt
}

#Function calls
passw0rd
passw2rd

#Concatenate the two checksums and echo to a file
cat firstsum.txt >> secondsum.txt
echo "$(sha512sum secondsum.txt)" > tmp4.txt   

#Make the script look like its doing something, for that USER EXPERIENCE (TM)
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

#Here's where the magic happens: Encode with a Caesar cipher corresponding to 30 random characters taken from openssl. Base64 encode that. Then re-Caesar it with your salt.
echo "$(less tmp4.txt | head -c 25 | rev | tr abcdefghijklmnopqrstuvwxyz $(openssl rand 30| base64) | tr abcdefghijklmnopqrstuvwxyz $salt)"

rm tmp.txt
rm tmp2.txt
rm tmp4.txt
rm firstsum.txt
rm secondsum.txt
