# This is a julia code to accomplish two tasks
    # Convert SRA to fastq
    # Run quality control over each read per sample

# Set up working directories
WORKDIR = "data/raw/"
REFDIR = "data/references/"


# Set up variables to be used for toy test case
d_files = ["ERR478975", "ERR478971", "ERR478968", "ERR478984", 
"ERR478989", "ERR478976", "ERR478980", "ERR478964", "ERR478962", "ERR478960"]

# Set up default command arguments for pipeline
human_db = "hdb_no"

# Grab any command line variables to be used
for vars in ARGS
    if contains(vars, "-hdb")
        human_db = vars
    else
        human_db = human_db
    end
end


# If not present download and create the human reference database
if contains(human_db, "no")
    
    run(`wget -P $REFDIR ftp://ftp.ccb.jhu.edu/pub/data/bowtie2_indexes/hg19.zip`)
    run(`unzip $REFDIR'*.zip' -d $REFDIR`)

elseif contains(human_db, "yes")

    println("db present moving to host sequence removal")
else
    println("must have yes or no to continue")
end


# Remove host sequences using bowtie2 and samtools
for sample in d_files
    
    # Map sequences to human (hg19)
    #run(`bowtie2 -x hg19 -1 $WORKDIR$sample'_qf_1.fastq' -2 $WORKDIR$sample'_qf_2.fastq' -S $WORKDIR$sample'_map_unmap.sam'`)
    # Convert files to bam
    run(pipeline(`samtools view -bS $WORKDIR$sample'_map_unmap.sam'`, "$WORKDIR$sample.map_unmap.bam"))
    
    # Filter unmapped pairs
    run(pipeline(`samtools view -b -f 12 -F 256 $WORKDIR$sample.map_unmap.bam`, "$WORKDIR$sample.bothends_unmap.bam"))
        # -f 12 = Extract only (-f) alignments with both reads unmapped: <read unmapped><mate unmapped>
        # -F 256 = Do not(-F) extract alignments which are: <not primary alignment>
    
    # split paired-ends reads into separated fastq d_files
    run(`samtools sort -n $WORKDIR$sample.bothends_unmap.bam $WORKDIR$sample'_bothends_unmap_sorted.bam'`)
    run(`bedtools bamtofastq -i $WORKDIR$sample'_bothends_unmap_sorted.bam' -fq $WORKDIR$sample'_hrm_r1.fastq' -fq2 $WORKDIR$sample'_hrm_r2.fastq'`)
end

















































