#!/bin/bash

for file in /home/ubuntu/BLOCK_COURSE/Projects/Project_C/data/IP*.fastq.gz

do 
 gunzip -c $file

done
