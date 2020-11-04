#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -N BIOS60132_FinalProject

#Load necessary module
module load julia/1.4.1

#Set inputs
merSize=16
sketchSize=400
inputNames="speciesList.txt"
outputDist="distanceMatrix.txt"
outputPhylo="phylogeneticTree.txt"

#Run julia script
julia ./sequenceDistance_phylogeny.jl $merSize $sketchSize $inputNames $outputDist $outputPhylo