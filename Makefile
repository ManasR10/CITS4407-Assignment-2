# Makefile for CITS4407 Assignment 2 

SHELL := /bin/bash

all: tiny_sample analysis_tiny sample analysis_sample sample1 analysis_sample1 full analysis_full

tiny_sample: tiny_sample.txt preprocess.sh
	./preprocess.sh tiny_sample.txt > tiny_sample_clean.tsv

analysis_tiny: tiny_sample_clean.tsv analysis.sh
	./analysis.sh tiny_sample_clean.tsv

sample: sample.txt preprocess.sh
	./preprocess.sh sample.txt > sample_clean.tsv

analysis_sample: sample_clean.tsv analysis.sh
	./analysis.sh sample_clean.tsv

sample1: sample1.txt preprocess.sh
	./preprocess.sh sample1.txt > sample1_clean.tsv

analysis_sample1: sample1_clean.tsv analysis.sh
	./analysis.sh sample1_clean.tsv

full: bgg_dataset.txt preprocess.sh
	./preprocess.sh bgg_dataset.txt > bgg_dataset_clean.tsv

analysis_full: bgg_dataset_clean.tsv analysis.sh
	./analysis.sh bgg_dataset_clean.tsv

clean:
	rm -f *_clean.tsv

.PHONY: all tiny_sample analysis_tiny sample analysis_sample sample1 analysis_sample1 full analysis_full clean