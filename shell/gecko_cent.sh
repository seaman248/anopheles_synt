#!/bin/bash

# docker-machine create \
# 	--driver google \
# 	--google-project gecko-anopheles \
# 	--google-zone europe-west1-c \
# 	--google-machine-type n1-highmem-8 \
# 	--google-disk-size 100 \
# 	--google-disk-type pd-ssd \
# 	vmgecko

# docker-machine ssh vmgecko mkdir anopheles_synt anopheles_synt/data

# docker-machine scp -r "$PWD/data/cent" vmgecko:/home/docker-user/anopheles_synt/data/chrs
# docker-machine scp -r "$PWD/gecko/bin" vmgecko:/home/docker-user/anopheles_synt/bin

# eval "$(docker-machine env vmgecko)"

mkdir -p ./data/cent_gecko_results
docker-machine ssh vmgecko mkdir -p ./anopheles_synt/data/cent_gecko_results

docker run --rm \
	-v /home/docker-user/anopheles_synt/:/anopheles_synt \
	-w /anopheles_synt/data/cent_gecko_results \
	ubuntu:latest \
	/anopheles_synt/bin/allVsAll.sh \
		/anopheles_synt/data/chrs \
		200 40 8 fasta

docker-machine scp -r \
	vmgecko:/home/docker-user/anopheles_synt/data/cent_gecko_results/results \
	$PWD/data/cent_gecko_results
