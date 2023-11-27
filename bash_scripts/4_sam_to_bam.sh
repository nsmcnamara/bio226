#!/bin/bash

for file in *_mapped.sam

do 

	bname=$(basename -s .sam $file)
	samtools view -b -S $bname.sam > $bname.bam

done
