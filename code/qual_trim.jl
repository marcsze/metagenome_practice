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


# Quality filter and toss out reads that don't make the cut 
# -t quality filter of nucleotide (trimmed from the end of sequence)
# -Q average quality cutoff of sequence
# -l minimum length of sequence if shorter after trimming it is tossed
for fastq_sample in d_files
    
    run(`sickle pe -f $WORKDIR/$fastq_sample'_1.fastq' -r $WORKDIR/$fastq_sample'_2.fastq' -t sanger -o $WORKDIR/$fastq_sample'_qf_1.fastq' -p $WORKDIR/$fastq_sample'_qf_2.fastq' -s $WORKDIR/$fastq_sample'_qf.orphan.fastq' -q 30 -l 75`)
    
end


#for sample in 1:10
#    println(sample)
#end







































