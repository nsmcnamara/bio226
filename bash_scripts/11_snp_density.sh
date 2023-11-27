#!/bin/bash

# calculate SNP density for autosomes in 10 kb windows
for i in {1..8}; 
	do 
	vcftools --vcf Variants_female.vcf --SNPdensity 10000 --chr chr${i} --out snps_${i}_female
	vcftools --vcf Variants_male.vcf --SNPdensity 10000 --chr chr${i} --out snps_${i}_male

	done
	
# do sex chromosomes
vcftools --vcf Variants_female.vcf --SNPdensity 10000 --chr chrU --out snps_U_female
vcftools --vcf Variants_male.vcf --SNPdensity 10000 --chr chrV --out snps_V_male
