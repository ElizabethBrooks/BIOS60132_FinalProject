#!/usr/bin/env julia

#Install Bio.jl using the package manager
#import Pkg
#Pkg.add("Bio")
#Pkg.add("DataFrames")
#Pkg.add("CSV")
#Pkg.add("PhyloNetworks")
#Pkg.add("Clustering")
#Pkg.add("PhyloTrees")
#Pkg.add("Plots")

#Ensure GR run-time is up-to-date, if necessary
#ENV["GRDIR"] = ""
#Pkg.build("GR")

#Load packages
println("Importing packages...")
using Bio.Seq
using Bio.Var
using DataFrames
using CSV
using PhyloNetworks
using Clustering
using PhyloTrees
using Plots
plotly()

#Retrieve inputs
merSize=parse(Int, ARGS[1])
sketchSize=parse(Int, ARGS[2])
inputNames=ARGS[3]
outputsPath=ARGS[4]

#Set output paths
outputDist=outputsPath * "/distanceMatrix.csv"
outputPhylo=outputsPath * "/dendroNetwork.txt"
outputTopo=outputsPath * "/dendroTopology.txt"
outputClust=outputsPath * "/dendroClusters.txt"
outputClustPlot=outputsPath * "/dendroClusters.png"
outputClustOp=outputsPath * "/dendroClustersOptimal.txt"
outputClustOpPlot=outputsPath * "/dendroClustersOptimal.png"

#Retrieve species list
nameDF=CSV.read(inputNames, header=false)
nameMatrix=convert(Matrix, nameDF)
numSpecies=size(nameMatrix, 1)

#Initialize data vectors
readList=Array{BioSequences.FASTA.Reader}(undef,numSpecies)
sketchList=Array{MinHashSketch}(undef,numSpecies)
nameList=Array{String}(undef,numSpecies)
distMat=zeros(numSpecies,numSpecies)

#Sketch FASTA files
nameList[1]="species"
for i in 1:numSpecies
	#Read input FASTA files
	println("Reading FASTA file ", nameMatrix[i,2])
	reads=open(FASTA.Reader, nameMatrix[i,2])
	readList[i]=reads
	#Generate MinHash sketches for each species
	println("Generating MinHash sketch for ", nameMatrix[i,1])
	sketch=minhash(reads, merSize, sketchSize)
	sketchList[i]=sketch
	#Create name vector for header
	nameList[i]=nameMatrix[i,1]
end

#Calculate pair-wise Jaccard distances
println("Calculating Jaccard distances...")
for i in 1:numSpecies
	for j in 1:numSpecies
		if i < j
			#Determine jaccard distance
			dist=GeneticVariation.distance(Jaccard, sketchList[i], sketchList[j])
			distMat[i,j]=1-dist
			distMat[j,i]=1-dist
		end
	end
end

#Output distance matrix to CSV
distDF=DataFrame(distMat)
CSV.write(outputDist, DataFrame(distMat), header=nameList)

#Infer dendrogram using neighbor joining
println("Performing neighbor joining...")
distCSV=CSV.read(outputDist, header=true)
resultTree=nj(distCSV)

#Write dendrogram to text file
io=open(outputPhylo, "w")
println(io, resultTree)
close(io)

#Write topology to text file
resultNet=writeTopology(resultTree)
io=open(outputTopo, "w")
println(io, resultTree)
close(io)

#Infer dendrogram using heirarchical clustering
println("Performing heirarchical clustering...")
resultClust=hclust(distMat)
resultClustOp=hclust(distMat, branchorder=:optimal)

#Write cluster results to text file
io=open(outputClust, "w")
println(io, resultClust)
close(io)
io=open(outputClustOp, "w")
println(io, resultClustOp)
close(io)

#Plot clustering dendrograms
plotClust=StatsPlots.plot(resultClust)
Plots.png(outputClustPlot)
plotClustOp=StatsPlots.plot(resultClustOp)
Plots.png(outputClustPlot)