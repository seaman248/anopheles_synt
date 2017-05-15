#!/bin/bash

docker pull bioconductor/release_core2

mkdir ./data/chrs

for script in $(ls ./R/1_process_sp/); do
	
	docker run --rm \
		-v "${PWD}:/anopheles_synt" \
		-w /anopheles_synt \
		bioconductor/release_core2 \
		Rscript "./R/1_process_sp/"$script

done