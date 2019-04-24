#!/usr/bin/bash
#Author:Tomoya Tsukimi
#Last update:2019-4-23

indir=$1
number=$2
outdir=$3

for i in `ls $indir`
do
    head -n $number $indir/$i > $outdir/${i/.fastq/_$number.fastq}
done
