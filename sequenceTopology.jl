#!/usr/bin/env julia

#Julia script to infer phylogenies from DNA or RNA sequnces using
# neighbor-joining and heriarchical clustering of MinHash sketches

#Import the package manager
import Pkg

#Activate MASP package
Pkg.activate("MASHP")

#Add necessary packages
#Pkg.add("Bio")
#Pkg.add("DataFrames")
#Pkg.add("CSV")
#Pkg.add("PhyloNetworks")
#Pkg.add("Clustering")
#Pkg.add("PhyloTrees")
#Pkg.add("StatsPlots")
#Pkg.add("ORCA")

#Ensure GR run-time is up-to-date, if necessary
ENV["GKSwstype"] = "100"

#Load packages
println("Importing packages...")
import MASHP
using Bio.Seq
using Bio.Var
using DataFrames
using CSV
using PhyloNetworks
using Clustering
using PhyloTrees
using StatsPlots

#Retrieve inputs
merSize=parse(Int, ARGS[1])
sketchSize=parse(Int, ARGS[2])
inputNames=ARGS[3]
outputsPath=ARGS[4]

#Set output paths
outputDist=outputsPath * "/distanceMatrix.csv"
outputTopo=outputsPath * "/dendroTopology.txt"
outputClustPlot=outputsPath * "/dendroClustersOptimal.png"

#Retrieve species list
nameDF=CSV.read(inputNames, header=false)
nameMatrix=convert(Matrix, nameDF)
numSpecies=size(nameMatrix, 1)

#Call function to generate MinHash sketches
# and estimate Jaccard distances and write to CSV
resultJD=MASHP.minJD(nameDF,nameMatrix,numSpecies,outputDist)

#Call function to infer dendrogram using neighbor joining
resultNJ=MASHP.minJD(outputDist)
#Write topology to text file
io=open(outputTopo, "w")
println(io, resultNJ)
close(io)

#Call function to infer dendrogram using hierarchical clustering
resultUPGMA=MASHP.minUPGMA(resultJD)
#Plot the dendrogam with species names on x-axis
#plotClust=plot(resultUPGMA, xticks=(1:numSpecies, ["$v" for (i,v) in enumerate(nameList)]))
#Plot the dendrogam with species as index numbers
plotClust=plot(resultUPGMA)
savefig(plotClust,outputClustPlot)
