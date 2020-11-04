#!/usr/bin/env julia

#Install Bio.jl using the package manager
#import Pkg
#Pkg.add("Bio")
#Pkg.add("DataFrames")
#Pkg.add("CSV")
#Pkg.add("PhyloNetworks")

#Load packages
println("Importing packages...")
using Bio.Seq
using Bio.Var
using DataFrames
using CSV
using PhyloNetworks

#Retrieve inputs
sketchSize=parse(Int, ARGS[1])
merSize=parse(Int, ARGS[2])
inputNames=ARGS[3]
outputDist=ARGS[4]
outputPhylo=ARGS[5]

#Retrieve species list
nameList=CSV.read(inputNames, DataFrame, header=false)
names=convert(Matrix, nameList)
numSpecies=length(names)

#Initialize data vectors
readList=Array{BioSequences.FASTA.Reader}(undef,numSpecies)
sketchList=Array{MinHashSketch}(undef,numSpecies)
distMat=zeros(numSpecies,numSpecies)

#Sketch FASTA files
for i in 1:numSpecies
	#Read input FASTA files
	println("Reading FASTA file ", names[i,2])
	reads=open(FASTA.Reader, names[i,2])
	readList[i]=reads
	#Generate MinHash sketches for each species
	println("Generating MinHash sketch for ", names[i,1])
	sketch=minhash(reads, merSize, sketchSize)
	sketchList[i]=sketch
end

#Calculate pair-wise Jaccard distances
for i in 1:numSpecies
	for j in 1:numSpecies
		if i < j
			#Determine jaccard distance
			println("Calculating Jaccard distance for ", names[i,1])
			dist=distance(Jaccard, sketchList[i], sketchList[j])
			global distMat[i,j]=dist
			global distMat[j,i]=dist
		end
	end
end

#Output distance matrix to CSV
println("Writting distance matrix to CSV...")
distDF=DataFrame(distMat)
CSV.write(outputDist, distDF, header=names)

#Infer tree using neighbor joining
println("Inferring phylogenetic tree...")
distCSV=CSV.read(outputDist, DataFrame, header=true)
resultTree=nj(distCSV)

#Write tree to text file
io=open(outputPhylo, "w")
println(io, resultTree)
close(io)