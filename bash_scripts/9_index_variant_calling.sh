#!/bin/bash 

# Index variant calling output

for file in Variants_*.bcf

do

	bcftools index $file

done
