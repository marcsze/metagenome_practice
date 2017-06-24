# This is a julia code to accomplish two tasks
    # Convert SRA to fastq
    # Run quality control over each read per sample

# Set up working directories
WORKDIR = "data/raw/"

# Set up shortcuts for keys and other things
asp = "/home/marcsze/.aspera/cli/etc/asperaweb_id_dsa.openssh"
sra_nih = "anonftp@ftp-private.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByStudy/sra"
database = "ERP"
seq_dir = "ERP005"
study = "ERP005534"

# Set up alias for outside programs to be run
fastx=`/nfs/turbo/schloss-lab/bin/fastx_0.0.13_precompiled/fastq_quality_trimmer`


# Set up variables to be used for toy test case
d_files = ["ERR478975", "ERR478971", "ERR478968", "ERR478984", 
"ERR478989", "ERR478976", "ERR478980", "ERR478964", "ERR478962", "ERR478960"]

# Download needed files from the SRA
for files in d_files

    run(`ascp -QTr -k 1 -l 1G -i $asp $sra_nih/$database/$seq_dir/$study/$files/ $WORKDIR`) 
    run(pipeline(`mv $WORKDIR$files/$files.sra $WORKDIR`, `rm -r $WORKDIR$files`))

end

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







































