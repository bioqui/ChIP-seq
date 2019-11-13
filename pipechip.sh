## This piperline analysis RNA-seq data
## Author: Juan Francisco Alba Valle & Claudia Muñoz Mesa
## Contact: juanfav98@gmail.com & claudiamzs22@gmail.com

#! bin/bash

if [ $# -eq 0 ]
	then
	echo "This pipeline analysis RNA-seq data"
	echo "Usage: piperna <param.file>"
	echo ""
	echo "param_file: File with the parameters specification. Please, check test/params.txt an examples"
	echo ""
	echo "Enjoy"

	exit 0
fi

## Parameters loading

PARAMS=$1

WD=$(grep working_directory: $PARAMS | awk '{ print $2 }')
NUMSAM=$( grep number_of_samples: $PARAMS | awk '{ print $2 }' )
GENOME=$( grep genome: $PARAMS | awk '{ print $2 }' )
ANNOTATION=$( grep annotation: $PARAMS | awk ' { print $2 }' )
NUMCHIP=$( grep chip: $PARAMS | awk ' { print $2 }' )
NUMINPUT=$( grep input: $PARAMS | awk ' { print $2 }' )

SAMPLES=( )


I=0
while [ $I - lt $NUSAM ]
do
	SAMPLES[$I]=$( grep samples_$(($I + 1)): $PARAMS | awk '{ print $2 }' )
	((I++))
done 




##Debugging printing variables values
echo "Reading paramaters from" $PARAMS

echo $WD
echo NUSAM=$NUSAM
echo GENOME=$GENOME
echo ANNOTATION=$ANNOTATION

I=0
while [ $I -lt $NUMSAM ]
do
	echo sample_$((I+1)) = ${SAMPLES[$I]}
	((I++))
done



##Generate working directory

mkdir $WD 

cd $WD

mkdir genome annotation samples results logs

cd samples

I=1
while [ $I -le $NUMCHIP ]
	do
	mkdir chip$I
	((I++))
done

I=1
while [ $I -le $NUMINPUT ]
        do
        mkdir input$I
        ((I++))
done

## Generate genome index
cd $WD/genome
cp $GENOME genome.fa 

cd ../annotation 
cp $ANNOTATION annotation.gtf


cd $WD/genome
bowtie2-build genome.fa index


## Copy samples
cd $WD/samples

I=0
while [ $I -lt $NUMCHIP ]
do
	cd chip(($I+1))
	fastq-dump --split-files ${SAMPLES[$I]}
        mv ${SAMPLES[$I]}_* chip(($I+1)) 
	cd ..
	((I++))
done

I=0
while [ $I -lt $NUMINPUT ]
do	cd input(($I+1))
        fastq-dump --split-files ${SAMPLES[($I+$NUSAM)]}
	mv ${SAMPLES[($I+$NUSAM)]}_* input(($I+1))
	cd ..
        ((I++))
done


I=1
while [ $I -le $NUMSAM ]
do
	qsub -N sample$I -o $WD/logs/sample$I rna_seq_sample_procesing.sh $I $WD $NUMSAM 
	((I++))
done

