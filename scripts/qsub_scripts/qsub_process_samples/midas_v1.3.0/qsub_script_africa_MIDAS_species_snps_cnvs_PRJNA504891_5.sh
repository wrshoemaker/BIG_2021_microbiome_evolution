#!/bin/bash
#$ -N MIDAS_2
#$ -e /u/project/ngarud/wrshoema/negative_selection_microbiome/scripts/postproc_error_2
#$ -o /u/project/ngarud/wrshoema/negative_selection_microbiome/scripts/postproc_output_2
#$ -cwd
#$ -r y
#$ -j y
#$ -l time=120:00:00
#$ -l h_data=34G
#$ -l highp

####ttt##$-tc 100 # Throttle to max 100 tasks at a time
########$-t 1-158
#######$-ltime=23:00:00


. /u/local/Modules/default/init/modules.sh

#module unload python
#module load python/2.7
#module load python/2.7.13




module unload python
module load anaconda/python2-4.2

#conda create -n midas python=2.7
#conda install biopython
#conda install numpy

source activate midas

module load samtools




export PYTHONPATH=$PYTHONPATH:/u/project/ngarud/Garud_lab/MIDAS
export PATH=$PATH:/u/project/ngarud/Garud_lab/MIDAS/scripts
export MIDAS_DB=/u/project/ngarud/Garud_lab/midas_db_v1.2


#readarray accs < /u/home/w/wrshoema/project-ngarud/madagascar_data/data/SRA_files/PRJNA485056/PRJNA485056_run_accessions_test2.txt
#accs=(null ${accs[@]}) # zero to one start index
#acc=${accs[$SGE_TASK_ID]}
#echo $acc







#samples_PRJNA485056=()

# {
#read
#while IFS= read -r acc; do
#    samples_PRJNA485056+=($acc)

#done
#} < /u/project/ngarud/wrshoema/madagascar_data/data/SRA_files/PRJNA485056/PRJNA485056_run_accessions.txt


#for acc in "${samples_PRJNA485056[@]}"
#do
#  echo $acc
#  OUTDIR=/u/project/ngarud/wrshoema/madagascar_data/data/midas_output/${acc}

#  mkdir -p $OUTDIR

#  fastq1=/u/project/ngarud/wrshoema/madagascar_data/data/SRA_files/PRJNA485056/${acc}_1.fastq.gz
#  fastq2=/u/project/ngarud/wrshoema/madagascar_data/data/SRA_files/PRJNA485056/${acc}_2.fastq.gz
#  run_midas.py species $OUTDIR -1 $fastq1 -2 $fastq2 --remove_temp
#  run_midas.py genes $OUTDIR -1 $fastq1 -2 $fastq2 --remove_temp
#  run_midas.py snps $OUTDIR -1 $fastq1 -2 $fastq2 --remove_temp
#done






samples_PRJNA504891=()

{
read
while IFS= read -r acc; do
    samples_PRJNA504891+=($acc)

done
} < /u/project/ngarud/wrshoema/negative_selection_microbiome/data/madagascar/PRJNA504891_run_accessions_5.txt

#/u/project/ngarud/wrshoema/madagascar_data/data/SRA_files/PRJNA504891/PRJNA504891_run_accessions.txt


for acc in "${samples_PRJNA504891[@]}"
do
  echo $acc
  OUTDIR=/u/project/ngarud/wrshoema/madagascar_data/data/midas_output/${acc}

  mkdir -p $OUTDIR

  fastq1=/u/project/ngarud/wrshoema/madagascar_data/data/SRA_files/PRJNA504891/${acc}_1.fastq.gz
  fastq2=/u/project/ngarud/wrshoema/madagascar_data/data/SRA_files/PRJNA504891/${acc}_2.fastq.gz
  #run_midas.py species $OUTDIR -1 $fastq1 -2 $fastq2 --remove_temp
  # we dont need species unions
  #--extra_species_file $species_union
  run_midas.py genes $OUTDIR -1 $fastq1 -2 $fastq2 --remove_temp
  run_midas.py snps $OUTDIR -1 $fastq1 -2 $fastq2 --remove_temp
done




#samples_all=("${samples_PRJNA485056[@]}" "${samples_PRJNA504891[@]}")
