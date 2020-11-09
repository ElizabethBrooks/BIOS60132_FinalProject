#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -N BIOS60132_FinalProject

#Load necessary module
module load julia/1.4.1

#Retrieve input arguments
mer=$1 #16 or 21
sketch=$2 #400 or 1000
target=$3 #genomic or rna

#Set inputs for julia script
merSize=$mer
sketchSize=$sketch
inputNames=$target"List.csv"
outputsPath="../Data/Results_FinalProject/run9/"$target"_k"$merSize"s"$sketchSize

#Make outputs directory
mkdir $outputsPath

#Run julia script
julia ./sequenceDistances_topology.jl $merSize $sketchSize $inputNames $outputsPath
