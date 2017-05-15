#!/bin/bash

baseHTTP=https://www.vectorbase.org/download

alb_source=anopheles-albimanus-steclachromosomesaalbs2fagz
atr_source=anopheles-atroparvus-ebroscaffoldsaatre1fagz
gam_source=anopheles-gambiae-pestchromosomesagamp4fagz

names=([0]="alb" [1]="atr" [2]="gam")
sources=([0]="anopheles-albimanus-steclachromosomesaalbs2fagz" [1]="anopheles-atroparvus-ebroscaffoldsaatre1fagz" [2]="anopheles-gambiae-pestchromosomesagamp4fagz");

mkdir ./data/source_fasta

for key in ${!sources[@]}; do
	wget "$baseHTTP/${sources[$key]}" -O "${names[$key]}.fa.gz"

	zcat -c < "${names[$key]}.fa.gz" >> "./data/source_fasta/${names[$key]}.fa"

	rm "${names[$key]}.fa.gz"
done

