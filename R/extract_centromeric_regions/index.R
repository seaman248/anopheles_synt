lapply(c(
  'Biostrings'
), require, character.only=T)

# if 1 from start if -1 from end
to_trim <- c(
  1, -1, 1, 1, -1,
  -1, -1, 1, -1, 1,
  1, -1, 1, -1, 1
)
names(to_trim) <- unlist(lapply(c('alb', 'atr', 'gam'), paste0, paste0('_e', 1:5)))

## Import all elements
chrs_dir <- './data/chrs'

DNAs <- lapply(paste0('e', 1:5), function(el){
  el_path <- paste0(chrs_dir, '/', el)
  lapply(dir(el_path), function(sp_file){
    fasta_path <- paste0(el_path, '/', sp_file)
    
    DNA <- readDNAStringSet(fasta_path)
    
    names(DNA) <- paste0(substr(sp_file, 1, 3), '_', el)
    DNA
  })
})

DNAs <- unlist(DNAs)

c_DNAs <- lapply(DNAs, function(set){
  id <- names(set)
  if(to_trim[id] == -1){
    set[[1]] <- reverse(set[[1]])
  }
  set[[1]] <- set[[1]][1:1000000]
  set
})

names(c_DNAs) <- unlist(lapply(c_DNAs, function(cDNA){
  names(cDNA)
}))

dir.create('./data/cent', showWarnings = F)
lapply(names(c_DNAs), function(id){
  writeXStringSet(c_DNAs[[id]], filepath = paste0('./data/cent/', id, '.fasta'))
})

