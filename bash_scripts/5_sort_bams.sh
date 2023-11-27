#!/bin/bash

for file in *.bam

do

	bname=$(basename -s .bam $file)
	result=${bname}_sorted.bam

	samtools sort $file -o $result

done
