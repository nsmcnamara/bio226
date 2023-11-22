#!/bin/bash

# build reference database for male and female separately
# loop through reference genomes 
for genome in /home/ubuntu/BLOCK_COURSE/Projects/Project_C/data/*Autosome*fasta

do 
  
	bwa index -a is $genome
	
done