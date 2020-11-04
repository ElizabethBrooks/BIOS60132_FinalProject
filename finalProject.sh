#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -N BIOS60132_FinalProject

#Load necessary module
module load julia/1.4.1

#Set inputs
merSize=16
sketchSize=400
inputNames="speciesList.csv"
outputDist="distanceMatrix.csv"
outputPhylo="treeNetwork.txt"
outputTopo="treeTopology.txt"

#Run julia script
julia ./sequenceDistance_phylogeny.jl $merSize $sketchSize $inputNames $outputDist $outputPhylo $outputTopo