#Working with FASTA

library(seqinr)
library(ape)
library(rentrez)
library(Peptides)

#Read a local FASTA file
cox1 <- read.fasta(file="cox1.fasta", seqtype = "AA")

seq1 <- cox1[1]

#Retrieve a GENBANK sequence as a binary object
AB003468 <- read.GenBank("AB003468", as.character= "TRUE")

#Save Genbank Sequence as FASTA format
write.dna(AB003468, file="AB003468.fasta", format="fasta", append= FALSE, nbcol= 6, colsep="", colw=10)

#Strip first sequence of AB003468 into just characters
CloningVector <- AB003468[[1]]

#Do a basic nucleotide count on CloningVector
count <- count(CloningVector, 1)


count(CloningVector, 2)
count(CloningVector, 3)

#Compute the GC content of CloningVector
GC <- GC(CloningVector)

#Compute windows of size 200 for our sequence
GCwindow <- seq(1, length(CloningVector)-200, by = 200)

#Find the length of the vector GCwindow
n <- length(GCwindow)
#Make a vector the same length but "blank" for us to fill 
Chunks <- numeric(n)

#FOR loop to compute GC per chunk
for (i in 1:n) {
  chunk <- CloningVector [GCwindow[i]:(GCwindow[i]+199)]
  chunkGC <- GC(chunk) 
  print(chunkGC)
  Chunks[i] <- chunkGC
}

plot(GCwindow, Chunks, type="b", xlab="Nucleotide start position", ylab="GC content")

#Custom Function for GC Window Plotting
slidingwindowGCplot <- function(windowsize, inputseq)
{
  GCwindow <- seq(1, length(inputseq)-windowsize, by=windowsize)
  
  #Find length of the GCwindow
  n <- length(GCwindow)
  
  #Make a vector the same length but "blank" for us to fill.
  Chunks <- numeric(n)

for (i in 1: n) {
  chunk <- inputseq[GCwindow[i]:(GCwindow[i]+windowsize-1)]
  chunkGC <- GC(chunk)
  print(chunkGC)
  Chunks[i] <- chunkGC
}
plot(GCwindow,Chunks,type="b",xlab="Nucleotide start position",ylab="GC content", main=paste("GC Plot with windowsize ", windowsize))
}


