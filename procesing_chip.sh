## Author: Juan Francisco Alba Valle
## Contact: juanfav98@gmail.com

#! /bin/bash

## Readin inut parameters

SAMPLE_ID=$1
WD=$2
NUM_SAM=$3
SCRIP=$4

## Access samples folder
cd $WD/samples/sample${SAMPLE_ID}

## QC/home/bioqui/sofware/PIPERNA
fastqc sample${SAMPLE_ID}.fq.gz

## MAPEO
hisat2 --dta -x $WD/genome/index -U sample${SAMPLE_ID}.fq.gz -S sample${SAMPLE_ID}.sam
samtools sort -o sample${SAMPLE_ID}.bam sample${SAMPLE_ID}.sam
rm sample${SAMPLE_ID}.sam

samtools index sample${SAMPLE_ID}.bam

## Transcript assembly
stringtie -G $WD/annotation/annotation.gtf -o sample${SAMPLE_ID}.gtf -l sample${SAMPLE_ID} sample${SAMPLE_ID}.bam

##Preparing merge list file for transcriptome merging
stringtie -e -B -G $WD/annotation/annotation.gtf -o sample${SAMPLE_ID}.gtf -l sample${SAMPLE_ID}.bam

## Synchronization point, trough blackboards
echo "sample${SAMPLE_ID} DONE" >> $WD/logs/blackboard.txt

## Preparing merge list file for transcriptome mergin
echo $WD/samples/sample${SAMPLE_ID}/sample${SAMPLE_ID}.gtf >> $WD/logs/mergelist.txt

DONE_SAMPLES=$(cat $WD/logs/blackboard.txt | grep "DONE" | wc -l)

if [ ${DONE_SAMPLES} -eq ${NUM_SAM} ]
then
	qsub -N transcriptome_assambly.sh -o $WD/logs/ensamblado_transcritos $SCRIP/transcriptome_assambly.sh $WD
	((I++))
fi
