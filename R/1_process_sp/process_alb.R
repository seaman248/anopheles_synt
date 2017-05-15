lapply(c('dplyr', 'Biostrings'), require, character.only = T)

# load data
albDNAStringSet <- readDNAStringSet('./data/source_fasta/alb.fa')
elements <- jsonlite::fromJSON(txt = './config/elements.json')

names(albDNAStringSet) <- lapply(names(albDNAStringSet), function(name){
  strsplit(name, ' ')[[1]][1]
})


albDNAStringSet <- albDNAStringSet[c('X', '2R', '2L', '3R', '3L')]

names(albDNAStringSet) <- paste0('e', elements$alb)

# save
lapply(names(albDNAStringSet), function(chr){
  chrdir <- paste0('./data/chrs/', chr)
  if(!dir.exists(chrdir)){dir.create(chrdir)}
  
  writeXStringSet(albDNAStringSet[chr], paste0(chrdir, '/alb_', chr, '.fasta'), format = 'fasta')
})