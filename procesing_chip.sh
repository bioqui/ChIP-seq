## Author: Juan Francisco Alba Valle & Claudia Muñoz Mesa
## Contact: juanfav98@gmail.com/ claudiamzs22@gmail.com

#! /bin/bash

## Reading input parameters

ID=$1
WD=$2
NUMSAM=$3
SCRIPT=$4
USUARIO=$5

cd $WD/samples/chip_${ID}


##No se produce el fastqc --> buscar fallo
fastqc chip${ID}.fastq

## Aqui hay también un fallo y por eso no funciona lo siguiente
bowtie2 -x $WD/genome/index -U chip${ID}.fastq -S chip${ID}.sam
samtools view -@ 2 -S -b chip${ID}.sam > chip${ID}.bam
rm chip${ID}.sam

samtools sort chip${ID}.bam -o chip_sorted${ID}.bam
samtools index chip_sorted${ID}.bam

echo "chip${ID} DONE" >> $WD/logs/blackboard.txt

DONE_SAMPLES=$(cat $WD/logs/blackboard.txt | grep "DONE" | wc -l)

if [ ${DONE_SAMPLES} -eq ${NUMSAM} ]
then
	cd $WD/results
	macs2 callpeak -t $WD/samples/chip_${ID}/chip_sorted${ID}.bam -c $WD/samples/input_${ID}/input_sorted${ID}.bam -n callpeak${ID} --outdir $WD/results -f BAM

fi

mv ${USUARIO}chip${ID}.fastq* $WD/logs 
mv ${USUARIO}input${ID}.fastq* $WD/logs

