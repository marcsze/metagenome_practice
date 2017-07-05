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

# Create empty dictionary to store matched data
test = Dict()

# Overall loop to calculate seq counts
#for sample in d_files

    # aggregate all lines with "@" and save these lines to a temp file
#    run(pipeline(`grep '^@' $WORKDIR/$sample$file_suffix`, "$WORKDIR/test.txt"))

    # get total counts of sequences by counting lines in temp file
#    test[sample] = countlines("$WORKDIR/test.txt")

    # Remove the temporary file
#    run(`rm $WORKDIR/test.txt`)

#end


# COunter is not working need to figure out how to make it work 
# Also counting on the @ is not good need to start with @

for sample in d_files

    counter = 0
    f = open("$WORKDIR/$sample$file_suffix");
    
    for ln in eachline(f)
        
        println(ln)

        if contains("@", ln)
            
            counter += 1
        end
    end
    
    close(f)

    test[sample] = counter
end






# Create empty vector to hold counts
total_counts = []

# Create a vector with the seqeunce counts
for sequence in d_files

    # Append new counts to the end of the vector being used
    total_counts = push!(total_counts, test[sequence])

end

# Create a data frame with the data
test2 = DataFrame(  Samples = d_files, 
                    Seq_counts  = total_counts)

# Save the results to the working directory
writetable("$WORKDIR/test.csv", test2)












































