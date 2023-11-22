#!/bin/bash

# Create an array for females
females=(
    "IPPQ_PCRfree_NILSC18_NILSC18_GCCACAGG_Marchantia_polymorpha_I860_L1"
    "IPPD_PCRfree_Ber-C_Bernac-C_TGCGGCGT_Marchantia_polymorpha_I860_L1"
    "IPPE_PCRfree_Bul-A_Bulan-A_CATAATAC_Marchantia_polymorpha_I860_L1"
    "IPNN_PCRfree_Dur-A_Durban_arize-A_AAGATACT_Marchantia_polymorpha_I860_L1"
)

femalereference=MpTak_v6.1.genome_Autosome_Xchr.fasta

# Loop through the female files
for file in "${females[@]}"; do

        # Align 
        bwa sampe -t 4 $femalereference ${file}_R1.fastq.gz ${file}_R2.fastq.gz 2> ${file}.err > ${file}_mapped.sam
done



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

        # Align
        bwa sampe -t 4 $malereference ${file}_R1.fastq.gz ${file}_R2.fastq.gz 2> ${file}.err > ${file}_mapped.sam
done