#!/bin/bash

#Create variable of the first 150 bytes of /dev/urandom output
randomness=$(cat /dev/urandom | head -c 150)

#Create variable using temperature anisotropies of the Cosmic Microwave Background from NASA's website
background=$(curl https://lambda.gsfc.nasa.gov/data/suborbital/ACT/act_v2/TotalSpectra/spectrum_ACTEplusS_148x148.dat)

#Calculate the first 1000 digits of Pi
pi=$(echo "scale=1000; 4*a(1)" | bc -l)

#Function collates these three variables into a text file, then calculates the sha512 checksum of the file and directs the result to a new file named firstsum.txt
function passw0rd {
	echo $randomness > tmp.txt
	echo $background >> tmp.txt
	echo $pi >> tmp.txt
	echo "$(sha512sum tmp.txt)" > firstsum.txt
}

#Function collates the three variables again, calculates a new sha512 checksum, directs the output to a new file named secondsum.txt
function passw2rd {
	echo $randomness > tmp2.txt
	echo $background >> tmp2.txt
	echo $pi >> tmp2.txt
	echo "$(sha512sum tmp2.txt)" > secondsum.txt
}

#Function calls
passw0rd
passw2rd

#Concatenate first checksum and second checksum
cat firstsum.txt >> secondsum.txt

#Create third checksum of the combined checksums and create a new file with it
echo "$(sha512sum secondsum.txt)" > tmp4.txt

#Make it look like the program is doing something
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

#Take first 25 bytes of the final checksum, reverse it, and encode with a Caesar Cipher corresponding to the alphabet backwards and all capitalized. Print to terminal as new password.
echo "$(less tmp4.txt | head -c 25 | rev | tr abcdefghijklmnopqrstuvwxyz ZYXWVUTSRQPONMLKJIHGFEDCBA)"

#Cleanup all the temp files we fucked around with
rm tmp.txt
rm tmp2.txt
rm tmp4.txt
rm firstsum.txt
rm secondsum.txt
