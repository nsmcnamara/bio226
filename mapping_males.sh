#!/bin/bash

# Create an array for males
males=(
"IPMR_PCRfree_NILSC23_NILSC23_AACGTTCC_Marchantia_polymorpha_I860_L1"
"IPML_PCRfree_AUX1_RES50_TAATACAG_Marchantia_polymorpha_I860_L1"
"IPND_PCRfree_Ale-A_Aleu-A_TACCGAGG_Marchantia_polymorpha_I860_L1"
"IPPR_PCRfree_NILSC3_NILSC3_ATTGTGAA_Marchantia_polymorpha_I860_L1"
)

malereference=MpTak_v6.1.genome_Autosome_Ychr.fasta

# Loop through the male files
for file in "${males[@]}"; do

		# Print to screen 
		echo "Processing file" $file "with reference" $malereference
		
        # Align
        bwa bwasw -t 4 -s 5 $malereference ${file}_R1.fastq.gz ${file}_R2.fastq.gz 2> ${file}.err > ${file}.sam
done