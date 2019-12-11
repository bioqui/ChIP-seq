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
TEST=$( grep test: $PARAMS | awk ' { print $2 } ' )
SCRIPT=$( grep script: $PARAMS  | awk ' { print$2 } ' )
TEST2=$( grep test2: $PARAMS | awk ' { print $2 } ' )

SAMPLES=()

## Create a sample parameter with all information about samples.

I=0
while [ $I -lt $NUMSAM ]
do
	SAMPLES[$I]=$( grep samples_$(($I + 1)): $PARAMS | awk '{ print $2 }' )
	((I++))
done 




##Debugging printing variables values
echo "Reading paramaters from" $PARAMS

echo $WD
echo NUMSAM=$NUMSAM
echo GENOME=$GENOME
echo ANNOTATION=$ANNOTATION
echo NUMCHIP=$NUMCHIP
echo NUMINPUT=$NUMINPUT
echo TEST=$TEST
echo TEST=$TEST2
echo SCRIPT=$SCRIPT

I=0
while [ $I -lt $NUMSAM ]
do
	echo sample_$(($I+1)) = ${SAMPLES[$I]}
	((I++))
done



##Generate working directory

mkdir $WD

cd $WD

mkdir genome annotation samples results logs

cd results

mkdir RSTUDIO HOMER

cd $WD/samples

I=1
while [ $I -le $NUMCHIP ]
	do
	mkdir chip_$I
	((I++))
done

I=1
while [ $I -le $NUMINPUT ]
        do
        mkdir input_$I
        ((I++))
done

## Copy or download genome & Generate genome index.

if [ $TEST == "yes" ]
then
	cd $WD/genome
	cp $GENOME genome.fa

	cd ../annotation
	cp $ANNOTATION annotation.gtf

	cd $WD/genome
	bowtie2-build genome.fa index

elif [ $TEST == "no" ]
then
	cd $WD/genome
	wget -O genome.fa.gz $GENOME
	gunzip genome.fa.gz

	cd ../annotation
	wget -O annotation.gtf $ANNOTATION
	gunzip annotation.gtf

	cd $WD/genome
	bowtie2-build genome.fa index
fi

## Copy or download samples in their correct directory. 

cd $WD/samples

if [ $TEST == "yes" ]
then
	I=0
        while [ $I -lt $NUMCHIP ]
        do
                cp ${SAMPLES[$I]} chip_$(($I+1))/chip$(($I+1)).fastq
                ((I++))
        done

        I=0
        while [ $I -lt $NUMINPUT ]
        do
                cp ${SAMPLES[(($I+$NUMCHIP))]} input_$(($I+1))/input$(($I+1)).fastq
                ((I++))
	done

elif [ $TEST = "no" ]
then
	I=0
	while [ $I -lt $NUMCHIP ]
	do
		fastq-dump --split-files ${SAMPLES[$I]}
		mv ${SAMPLES[$I]}_* chip$(($I+1)).fastq
		mv chip$(($I+1)).fastq $WD/samples/chip_$(($I+1))
		((I++))
	done

	I=0
	while [ $I -lt $NUMINPUT ]
	do
		fastq-dump --split-files ${SAMPLES[(($I+$NUMCHIP))]}
		mv ${SAMPLES[(($I+$NUMCHIP))]}_* input$(($I+1)).fastq
		mv input$(($I+1)).fastq $WD/samples/input_$(($I+1))
		((I++))
	done
fi

## Uploading processing_input & processing_chip to continue with their analyzes.

I=1
while [ $I -le $NUMINPUT ]
do 
	qsub -N input$I -o $WD/logs/input$I $SCRIPT/procesing_input.sh $I $WD $NUMSAM $SCRIPT $TEST2
	((I++))
done

I=1
while [ $I -le $NUMCHIP ]
do
	qsub -N chip$I -o $WD/logs/chip$I $SCRIPT/procesing_chip.sh $I $WD $NUMSAM $SCRIPT $TEST2
	((I++))
done
