#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -N BIOS60132_FinalProject

#Extract compressed package files
tar -xf MASHP.tar.gz

#Load necessary module
module load julia/1.4.1

#Retrieve input arguments
mer=$1 #16 or 21
sketch=$2 #400 or 1000
inputs=$3 #dnaList.csv or rnaList.csv
outputs=$4 #directory for output files

#Set inputs for julia script
merSize=$mer #Size of k mer
sketchSize=$sketch #Size of MASH sketch
results=$outputs"/MASHP_k"$merSize"s"$sketchSize

#Make results sub directory
mkdir $results

#Run julia script
julia ./sequenceTopology.jl $merSize $sketchSize $inputs $results
