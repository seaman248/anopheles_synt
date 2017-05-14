#!/bin/bash

elements=$(ls ./data/chrs)

mkdir ./data/gecko_results

for el in $elements; do

	mkdir './data/gecko_results/'$el

	docker run --rm \
		-v /Users/seaman/prog/r/anopheles_synt/:/anopheles_synt \
		-w '/anopheles_synt/data/gecko_results/'$el \
		ubuntu:latest \
		/anopheles_synt/gecko/bin/allVsAll.sh \
			'/anopheles_synt/data/chrs/'$el \
			200 45 8 fasta

done



