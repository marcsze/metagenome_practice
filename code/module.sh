#!bash

#Load needed modules
# Needs to be executed with the source command not with bash
module load R/3.3.3
module load julia/0.5.2
module load sratoolkit/2.8.2-1
module load samtools/1.3.1
module load bowtie2/2.1.0
module load sickle/1.33.6
module load bedtools2/2.20.1

# Control pathing
export BOWTIE2_INDEXES=/nfs/turbo/schloss-lab/msze/active_projects/metagenome_practice/data/references

