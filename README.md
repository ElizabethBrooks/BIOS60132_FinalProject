# BIOS60132_FinalProject

## Abstract
Natural populations are regularly confronted with environmental challenges, including increasing
levels of ultraviolet radiation (UVR). A primary goal of evolutionary biology is to understand the
evolution of mechanisms that underlie adaptive phenotypes. Aquatic species have evolved
three mechanisms in response to survive under harmful levels of UVR: avoidance,
photoprotection, and dark repair. The goals of this study are to use RNA-seq data to infer
phylogenetic trees for high and low tolerance *Daphnia melanica* genotypes. A common method is to
assemble the short reads to generate sequence contigs, which are then mapped onto reference
transcripts. An alternative approach is to directly map the reads to the reference coding
sequences of a closely related species, such as *Daphnia pulex*. Our long-term goal is to build
on the results of this study to investigate independent adaptation to high UVR environments
across the genus.

## Question Asked
How do divergent adaptive phenotypes arise in naturally subdivided populations of *Daphnia*?

## Team
- Elizabeth Brooks

## New Code Required
Pairwise comparison of the similarity between MinHash sketches of RNA or DNA sequence read sets for each species to guide the generation of phylogenetic trees.

## Activities Required
1. Prepare sets of DNA or RNA sequences for each species:
- QC, trim, and concatenate or assemble paired-end RNA-seq reads in FASTA format
- Download set of DNA sequences in FASTA format
2. Estimate Jaccard distances between species DNA or RNA sequnces using MinHash sketches
3. Infer dendrograms from pairwise distance matrix using neighbor-joining (NJ) or hierarchical clustering (UPGMA)

## Data Used
1. Paired-end RNA-seq reads for four *Daphnia melanica* genotypes from the Olympic mountains, one *Daphnia melanica* from the Sierra mountains, and one *Daphnia pulex* from the Portland Arch

| Genotype | Treatment | Replicates |
| -------- | --------- | ---------- |
| E05 | UVR | 3 |
| E05 | Visible light | 3 |
| Y05 | UVR | 3 |
| Y05 | Visible light | 3 |
| Y023_5 | UVR | 3 |
| Y023_5 | Visible light | 3 |
| R2 | UVR | 3 |
| R2 | Visible light | 3 |
| PA | UVR | 3 |
| PA | Visible light | 3 |
| Sierra | UVR | 3 |
| Sierra | Visible light | 3 |

2. The well annotated PA42 *Daphnia pulex* reference coding sequences

3. Genomic sequences for 24 arthropod species (or versions) downloaded from the NCBI database

| Species | Common Name |
| ------- | ----------- |
| Daphnia pulex 3.0 | common water flea |
| Daphnia pulex 4.1 | common water flea |
| Daphnia pulex 1.0 | common water flea |
| Daphnia carinata | crustaceans |
| Daphnia magna 1 | crustaceans |
| Daphnia magna 2.4 | crustaceans |
| Daphnia dubia | crustaceans |
| Penaeus vannamei | Pacific white shrimp |
| Penaeus monodon | black tiger shrimp |
| Drosophila melanogaster | fruit fly |
| Drosophila pseudoobscura | flies |
| Drosophila mojavensis | flies |
| Anopheles gambiae | African malaria mosquito |
| Culex quinquefasciatus | southern house mosquito |
| Aedes aegypti | yellow fever mosquito |
| Bombyx mori | domestic silkworm |
| Tribolium castaneum | red flour beetle |
| Apis mellifera | honey bee |
| Nasonia vitripennis | jewel wasp |
| Rhodnius prolixus | bugs |
| Acyrthosiphon pisum | pea aphid |
| Pediculus humanus | human body louse |
| Ixodes scapularis | black-legged tick |
| Tetranychus urticae | two-spotted spider mite |
