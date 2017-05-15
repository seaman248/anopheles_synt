#!/bin/bash

docker pull r-base

mkdir ./data/chrs

for script in $(ls ./R/1_process_sp/); do
	
	docker run --rm -d \
		-v "${PWD}:/anopheles_synt" \
		-w /anopheles_synt \
		r-base:latest \
		Rscript "./R/1_process_sp/"$script

done