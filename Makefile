# Makefile for CITS4407 Assignment 2 

SHELL := /bin/bash

all: tiny_sample analysis_tiny sample analysis_sample sample1 analysis_sample1 full analysis_full

tiny_sample: tiny_sample.txt preprocess
	./preprocess tiny_sample.txt > tiny_sample_clean.tsv

analysis_tiny: tiny_sample_clean.tsv analysis
	./analysis tiny_sample_clean.tsv

sample: sample.txt preprocess
	./preprocess sample.txt > sample_clean.tsv

analysis_sample: sample_clean.tsv analysis
	./analysis sample_clean.tsv

sample1: sample1.txt preprocess
	./preprocess sample1.txt > sample1_clean.tsv

analysis_sample1: sample1_clean.tsv analysis
	./analysis sample1_clean.tsv

full: bgg_dataset.txt preprocess
	./preprocess bgg_dataset.txt > bgg_dataset_clean.tsv

analysis_full: bgg_dataset_clean.tsv analysis
	./analysis bgg_dataset_clean.tsv

clean:
	rm -f *_clean.tsv

.PHONY: all tiny_sample analysis_tiny sample analysis_sample sample1 analysis_sample1 full analysis_full clean