#!/bin/bash

# loop through fastq.gz files
for file in /home/ubuntu/BLOCK_COURSE/Projects/Project_C/data/IP*.fastq.gz

do 
  
  # run fastqc
  /home/ubuntu/BLOCK_COURSE/software/FastQC/fastqc -o /home/ubuntu/BLOCK_COURSE/Projects/Project_C/MiriamSimone/fastqc $file

done

