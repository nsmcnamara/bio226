#!/bin/bash 

# reference
femalereference=MpTak_v6.1.genome_Autosome_Xchr.fasta
malereference=MpTak_v6.1.genome_Autosome_Ychr.fasta

# Variant calling of female files

samtools mpileup -C 50 -E -Q 13 -t DP -g -d 1000 -f $femalereference IPPQ_PCRfree_NILSC18_NILSC18_GCCACAGG_Marchantia_polymorpha_I860_L1_mem_mapped_sorted.bam IPPD_PCRfree_Ber-C_Bernac-C_TGCGGCGT_Marchantia_polymorpha_I860_L1_mem_mapped_sorted.bam IPPE_PCRfree_Bul-A_Bulan-A_CATAATAC_Marchantia_polymorpha_I860_L1_mem_mapped_sorted.bam IPNN_PCRfree_Dur-A_Durban_arize-A_AAGATACT_Marchantia_polymorpha_I860_L1_mem_mapped_sorted.bam > Variants_female.bcf


# Variant calling of female files        

samtools mpileup -C 50 -E -Q 13 -t DP -g -d 1000 -f $malereference IPMR_PCRfree_NILSC23_NILSC23_AACGTTCC_Marchantia_polymorpha_I860_L1_mem_mapped_sorted.bam IPML_PCRfree_AUX1_RES50_TAATACAG_Marchantia_polymorpha_I860_L1_mem_mapped_sorted.bam  IPND_PCRfree_Ale-A_Aleu-A_TACCGAGG_Marchantia_polymorpha_I860_L1_mem_mapped_sorted.bam IPPR_PCRfree_NILSC3_NILSC3_ATTGTGAA_Marchantia_polymorpha_I860_L1_mem_mapped_sorted.bam > Variants_male.bcf
