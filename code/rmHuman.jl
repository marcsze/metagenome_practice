# This is a julia code to accomplish two tasks
    # Convert SRA to fastq
    # Run quality control over each read per sample

# Set up working directories
WORKDIR = "data/raw/"


# Set up variables to be used for toy test case
d_files = ["ERR478975", "ERR478971", "ERR478968", "ERR478984", 
"ERR478989", "ERR478976", "ERR478980", "ERR478964", "ERR478962", "ERR478960"]


# If not present download and create the human reference database

# Remove host sequences using bowtie2 and samtools

# Map sequences to human (hg19)

# Filter unmapped pairs

# split paired-ends reads into separated fastq d_files












































