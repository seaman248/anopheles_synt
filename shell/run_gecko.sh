#!/bin/bash

elements=$(ls ./data/chrs)

mkdir -p ./data/gecko_results
docker-machine ssh vmgecko mkdir -p ./anopheles_synt/data/gecko_results

for el in $elements; do

	mkdir -p ./data/gecko_results/$el
	docker-machine ssh vmgecko mkdir -p './anopheles_synt/data/gecko_results/'$el

	docker run --rm \
		-v /home/docker-user/anopheles_synt/:/anopheles_synt \
		-w /anopheles_synt/data/gecko_results/$el \
		ubuntu:latest \
		/anopheles_synt/bin/allVsAll.sh \
			/anopheles_synt/data/chrs/$el \
			200 65 16 fasta

	docker-machine ssh vmgecko rm -rf ./anopheles_synt/data/gecko_results/$el/intermediateFiles

	docker-machine scp -r \
		vmgecko:/home/docker-user/anopheles_synt/data/gecko_results/$el/results \
		$PWD/data/gecko_results/$el/results

done




