gecko_res_dir <- './data/gecko_results'

results <- lapply(dir(gecko_res_dir), function(el_folder){
  path <- paste0(gecko_res_dir, '/', el_folder, '/results')
  csv_result <- paste0(path, '/', dir(path, pattern = 'csv'))
  
  lapply(csv_result, function(path){
    
    read.csv(path, header = T, stringsAsFactors = F, skip = 16)
  })
})
