# This is a julia code to accomplish two tasks
    # Convert SRA to fastq
    # Run quality control over each read per sample

# Set up working directories
WORKDIR = "data/raw/"

# Set up alias for outside programs to be run
fastx=`/nfs/turbo/schloss-lab/bin/fastx_0.0.13_precompiled/fastq_quality_trimmer`

# Convert sra to fastq files (F and R)
for sample in readdir(WORKDIR)
    
    if contains(sample, "sra")

        run(`fastq-dump --split-files $WORKDIR/$sample -O $WORKDIR`)
    
    end
    
end


#run(`$fastx -t 33 -Q 30 -l 75 -i $WORKDIR/ERR478975_1.fastq -o $WORKDIR/test_1`)



#for sample in 1:10
#    println(sample)
#end







































