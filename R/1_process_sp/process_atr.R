lapply(c('dplyr', 'Biostrings'), require, character.only = T)

# load data
atrDNAStringSet <- readDNAStringSet('./data/source_fasta/atr.fa')
atr_scfs <- read.csv('./data/atr_scfs.csv')
elements <- jsonlite::fromJSON(txt = './config/elements.json')

# rename DNAStringSet
names(atrDNAStringSet) <- lapply(names(atrDNAStringSet), function(name){
  strsplit(name, ' ')[[1]][1]
})

# Group and merge scaffold by chrs 
atrChrSets <- lapply(unique(atr_scfs$Chr), function(chr){
  chr_scfs <- atr_scfs %>%
    filter(Chr == chr, Strand != 0) %>%
    select(Scf, Strand)
  
  str_set <- atrDNAStringSet[chr_scfs$Scf]
  str_set[chr_scfs$Strand == -1] <- reverse(str_set[chr_scfs$Strand == -1])
  
  unlist(str_set)
})

atrChrSets <- DNAStringSet(atrChrSets)
# rename chromosomes according to atroparvus arm elements
names(atrChrSets) <- paste0('e', elements[['atr']])

# save
lapply(names(atrChrSets), function(chr){
  chrdir <- paste0('./data/chrs/', chr)
  if(!dir.exists(chrdir)){dir.create(chrdir)}
  
  writeXStringSet(atrChrSets[chr], paste0(chrdir, '/atr_', chr, '.fasta'), format = 'fasta')
})