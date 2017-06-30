# This is a julia code to accomplish two tasks
    # Convert SRA to fastq
    # Run quality control over each read per sample

# Set up working directories
WORKDIR = "data/raw"
REFDIR = "data/references/"

# Load Needed package
using DataFrames

# Set up variables to be used for toy test case
d_files = ["ERR478975", "ERR478971", "ERR478968", "ERR478984", 
"ERR478989", "ERR478976", "ERR478980", "ERR478964", "ERR478962", "ERR478960"]

# Set up default command arguments for pipeline
file_suffix = "_hrm_r2.fastq"

# Create empty vector to store counts
test = []

# Overall loop to calculate seq counts
for sample in d_files

    # aggregate all lines with "@" and save these lines to a temp file
    run(pipeline(`grep '^@' $WORKDIR/$sample$file_suffix`, "$WORKDIR/test.txt"))

    # get total counts of sequences by counting lines in temp file
    test = push!(test, countlines("$WORKDIR/test.txt"))

    # Remove the temporary file
    run(`rm $WORKDIR/test.txt`)

end

# Create a data frame with the data
test2 = DataFrame(  Samples = d_files, 
                    Seq_counts  = test)

# Save the results to the working directory
writetable("$WORKDIR/paired_seq_counts.csv", test2)












































