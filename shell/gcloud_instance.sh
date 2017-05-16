#!/bin/bash

docker-machine create \
	--driver google \
	--google-project gecko-anopheles \
	--google-zone europe-west1-c \
	--google-machine-type n1-highmem-8 \
	--google-disk-size 100 \
	--google-disk-type pd-ssd \
	vmgecko

docker-machine ssh vmgecko mkdir anopheles_synt anopheles_synt/data

docker-machine scp -r "$PWD/data/chrs" vmgecko:/home/docker-user/anopheles_synt/data/chrs
docker-machine scp -r "$PWD/gecko/bin" vmgecko:/home/docker-user/anopheles_synt/bin

# eval "$(docker-machine env vmgecko)"