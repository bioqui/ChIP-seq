## Author: Claudia Muñoz Mesa & Juan Francisco Alba Valle
## Contact: juanfav98@gmail.com/ claudiamzs22@gmail.com
## Processing of input files

#! /bin/bash

## Reading input parameters

ID=$1
WD=$2
NUMSAM=$3
SCRIPT=$4
TEST2=$5

## Quality analyses
cd $WD/samples/input_${ID}

fastqc input${ID}.fastq

## Generate index genome reference & transforme SAM to BAM

bowtie2 -x $WD/genome/index -U input${ID}.fastq -S input${ID}.sam
samtools view -@ 2 -S -b input${ID}.sam > input${ID}.bam
rm input${ID}.sam

samtools sort input${ID}.bam -o input_sorted${ID}.bam
samtools index input_sorted${ID}.bam

## Connection point

## Writing in a blackboard to synchronise chip and input files

echo "input${ID} DONE" >> $WD/logs/blackboard.txt

DONE_SAMPLES=$(cat $WD/logs/blackboard.txt | grep "DONE" | wc -l)

## Generating peaks

if [ ${DONE_SAMPLES} -eq ${NUMSAM} ]
then
        cd $WD/results
        macs2 callpeak -t $WD/samples/chip_${ID}/chip_sorted${ID}.bam -c $WD/samples/input_${ID}/input_sorted${ID}.bam -n callpeak${ID} --outdir $WD/results -f BAM
fi

## Annotation peaks, analysis GEO & KEGG by script in Rstudio // HOMER Analysis

if [ $TEST2 == "yes" ]
then

	## RSCRIPT

	cd $SCRIPT

	Rscript RScript.R $WD/results/callpeak1_peaks.narrowPeak $WD/results/RSTUDIO

	## HOMER

	cd $WD/results

	findMotifsGenome.pl callpeak1_summits.bed tair10 $WD/results/HOMER -size 60

fi

cd

mv chip${ID}.e* $WD/logs
mv input${ID}.e* $WD/logs

