#!/bin/bash 

# Index variant calling output

for file in Variants_*.bcf

do

	bname=$(basename -s .bcf $file)
	output=${bname}.vcf

	bcftools call -m -v --ploidy 1 $file -o $output

done

