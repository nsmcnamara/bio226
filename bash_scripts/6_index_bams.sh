#!/bin/bash

for file in *_sorted.bam

do

  samtools index $file

done
