## Author: Claudia Muñoz Mesa & Juan Francisco Alba Valle
## Contact: juanfav98@gmail.com/ claudiamzs22@gmail.com

#! /bin/bash

## Readin inut parameters

ID=$1
WD=$2
NUMSAM=$3

cd $WD/samples/input_${ID}

fastqc input${ID}.fastq

bowtie2 -x $WD/genome/index -U input${ID}.fastq -S input${ID}.sam
samtools view -@ 2 -S -b input${ID}.sam > input${ID}.bam
rm input${ID}.sam

samtools sort input${ID}.bam -o input_sorted${ID}.bam
samtools index input_sorted${ID}.bam

echo "input${ID} DONE" >> $WD/logs/blackboard.txt

DONE_SAMPLES=$(cat $WD/logs/blackboard.txt | grep "DONE" | wc -l)

if [ ${DONE_SAMPLES} -eq ${NUMSAM} ]
then
        cd $WD/results
        macs2 callpeak -t $WD/samples/chip_${ID}/chip_sorted${ID}.bam -c $WD/samples/input_${ID}/input_sorted${ID}.bam -n callpeak${ID} $

fi

