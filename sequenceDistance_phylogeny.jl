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
merSize=parse(Int, ARGS[1])
sketchSize=parse(Int, ARGS[2])
inputNames=ARGS[3]
outputDist=ARGS[4]
outputPhylo=ARGS[5]

#Retrieve species list
nameDF=CSV.read(inputNames, DataFrame, header=false)
nameMatrix=convert(Matrix, nameDF)
numSpecies=size(nameMatrix, 1)

#Initialize data vectors
readList=Array{BioSequences.FASTA.Reader}(undef,numSpecies)
sketchList=Array{MinHashSketch}(undef,numSpecies)
names=Array{String}(undef,numSpecies)
distMat=zeros(numSpecies,numSpecies)

#Sketch FASTA files
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
	names[i]=nameMatrix[i,1]
end

#Calculate pair-wise Jaccard distances
println("Calculating Jaccard distances...")
for i in 1:numSpecies
	for j in 1:numSpecies
		if i < j
			#Determine jaccard distance
			dist=distance(Jaccard, sketchList[i], sketchList[j])
			distMat[i,j]=1-dist
			distMat[j,i]=1-dist
		end
	end
end
#Print distance matrix to screen
distMat

#Output distance matrix to CSV
println("Writting distance matrix to CSV...")
distDF=DataFrame(distMat)
CSV.write(outputDist, distDF, header=names)

#Infer tree using neighbor joining
println("Inferring phylogenetic tree...")
distCSV=CSV.read(outputDist, DataFrame, header=true)
resultTree=nj(distCSV)
#Print tree to screen
resultTree

#Write tree to text file
io=open(outputPhylo, "w")
println(io, resultTree)
close(io)