# PseudosecurePGen
"Just because you can, doesn't mean you should."

A pointlessly convoluted script to generate a password based on sha512 checksums and Caesar Ciphers. This makes you feel secure without making you actually secure.

There is literally no good reason to generate a password this way. It doesn't give you any extra entropy and doesn't even include symbols, although the latter may come in an update next time I get bored at work.

How it works:

1a) Ask for the user to enter the salt they'd like to use

1) Take the first 150 bytes of /dev/urandom

2) Take the temperature anisotropies of the Cosmic Microwave Background from NASA's website

3) Calculate the first 1000 digits of Pi

4) Combine these together in a text file and run a sha512 checksum of the file

5) Save that checksum to a file

6) Do steps 1-5 again and make a second file

7) Concatenate the two checksum files into a single file

8) Create a checksum of that file

9) Take the first 25 bytes of that checksum, reverse them, replace the letters in it with a Caesar Cipher of 30 random characters, base64 encode that, then Caesar it with the user-provided salt

10) You now have your password
