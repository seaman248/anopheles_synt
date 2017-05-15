lapply(c('dplyr', 'Biostrings'), require, character.only = T)

# load data
gamDNAStringSet <- readDNAStringSet('./data/source_fasta/gam.fa')
elements <- jsonlite::fromJSON(txt = './config/elements.json')

names(gamDNAStringSet) <- lapply(names(gamDNAStringSet), function(name){
  strsplit(name, ' ')[[1]][1]
})


gamDNAStringSet <- gamDNAStringSet[c('X', '2R', '2L', '3R', '3L')]

names(gamDNAStringSet) <- paste0('e', elements$gam)

# save
lapply(names(gamDNAStringSet), function(chr){
  chrdir <- paste0('./data/chrs/', chr)
  if(!dir.exists(chrdir)){dir.create(chrdir)}
  
  writeXStringSet(gamDNAStringSet[chr], paste0(chrdir, '/gam_', chr, '.fasta'), format = 'fasta')
})