#!/bin/bash

# reference files
femalereference=MpTak_v6.1.genome_Autosome_Xchr.fasta
malereference=MpTak_v6.1.genome_Autosome_Ychr.fasta

# index reference files
samtools faidx femalereference
samtools faidx malereference

