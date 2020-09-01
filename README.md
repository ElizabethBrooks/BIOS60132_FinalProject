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

## Team
- Elizabeth Brooks

## New Code Required
Direct mapping of the RNA-seq reads for the four *Daphnia melanica* genotypes to the reference coding sequences of the closely related species of *Daphnia pulex* to guide the generation of phylogenetic trees.

## Activities Required
1. QC and trim RNA-seq reads
2. Directly map the RNA-seq reads to the PA42 reference coding sequences
3. Infer phylogenetic trees

## Data Used
1. Paired-end RNA-seq reads for four *Daphnia melanica* genotypes (Olympic mountains, WA), two tolerant and two not-tolerant to UVR

| Genotype | Treatment | Replicates |
| -------- | --------- | ---------- |
| E05 | UVR | 3 |
| E05 | Visible light | 3 |
| Y05 | UVR | 3 |
| Y05 | Visible light | 3 |
| Y023_5 | UVR | 3 |
| Y023_5 | Visible light | 3 |
| R2 | Visible light | 3 |
| R2 | UVR | 3 |

2. The well annotated PA42 *Daphnia pulex* reference genome and coding sequences

## Question Asked
How do divergent adaptive phenotypes arise in naturally subdivided populations of *Daphnia*?
