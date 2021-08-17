#!/bin/bash -l

#$ -l h_rt=06:00:00 #time requested (hh:mm:ss)
#$ -N qc_XYZ #name of job on server
#$ -j y #merges error and output files into single file
#$ -m ea #emails with errors or completion of job
#$ -M judamash@utica.edu #...email address

#$ -pe omp 16 #16 nodes requested
#$ -l mem_per_core=16G #16 gb per node requested

module load bowtie2/2.3.4.1
module load htslib/1.9 #on my server I need this to load samtools
module load samtools/1.9


bowtie2 -p 16 -x all_thaums_20180823_bowtie -q --interleaved XYZ.fastq --no-unal --very-sensitive -S XYZ.sam
samtools view -b XYZ.sam > XYZ-RAW.bam
samtools sort XYZ-RAW.bam -o XYZ-hitstoallthaums.bam
samtools index -b XYZ-hitstoallthaums.bam && rm -f XYZ.sam XYZ-RAW.bam
