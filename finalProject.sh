#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -N BIOS60132_FinalProject

#Extract compressed package files
tar -xf MASHP.tar.gz

#Load necessary module
module load julia/1.4.1

#Set input arguments for julia script
#Default k-mer of 21 and sketch size of 1000
# is recommended for closely related species
merSize=21 #16 or 21
sketchSize=1000 #400 or 1000
inputs="rnaList.csv" #dnaList.csv or rnaList.csv
outputs="." #directory for output files

#Set results sub-directory path
results=$outputs"/MASHP_k"$merSize"s"$sketchSize

#Make results sub-directory
mkdir $results

#Run julia script
julia ./sequenceTopology.jl $merSize $sketchSize $inputs $results
