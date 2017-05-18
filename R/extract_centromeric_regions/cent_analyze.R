res_dir <- './data/cent_gecko_results/results'

results <- bind_rows(lapply(dir(res_dir, pattern = 'csv'), function(filename){
  path <- paste0(res_dir, '/', filename)
  
  spX <- substr(filename, 1, 3)
  spX_el <- substr(filename, 5, 6)
  spY <- substr(filename, 8, 10)
  spY_el <- substr(filename, 12, 13)

  res <- read.csv(path, skip = 16, header = T)[, c(2, 3, 4, 5, 6, 8, 12)]
  
  res$spX <- rep(spX, nrow(res))
  res$spX_el <- rep(spX_el, nrow(res))
  res$spY <- rep(spY, nrow(res))
  res$spY_el <- rep(spY_el, nrow(res))
  
  res
  
}))

sum_res <- results %>%
  filter(spX != spY, spX_el != spY_el) %>%
  group_by(spX, spY, spX_el, spY_el) %>%
  summarise(n_blocks = n(), mean_blocks_length = mean(length), mean_blocks_identity = mean(X.ident))

write.csv2(sum_res, './data/cent_gecko_results/R_results/sum_res.csv', row.names = F, quote = F)
