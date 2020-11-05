#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -N BIOS60132_FinalProject

#Load necessary module
module load julia/1.4.1

#Set inputs
merSize=16
sketchSize=400
inputNames="genomicList.csv"
outputDist="../Data/Results_FinalProject/distanceMatrix_genomic.csv"
outputPhylo="../Data/Results_FinalProject/treeNetwork_genomic.txt"
outputTopo="../Data/Results_FinalProject/treeTopology_genomic.txt"

#Run julia script
julia ./sequenceDistance_phylogeny.jl $merSize $sketchSize $inputNames $outputDist $outputPhylo $outputTopo