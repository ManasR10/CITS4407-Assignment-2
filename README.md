# CITS4407-Assignment-2

**Author:** Manas Rawat  
**Unit:** CITS4407 Systems Programming  
**Semester:** 1, 2025  
**UWA Student ID:** 24004729

---

## Table of Contents

- [CITS4407-Assignment-2](#cits4407-assignment-2)
  - [Table of Contents](#table-of-contents)
  - [Project Overview](#project-overview)
  - [Scripts and Their Roles](#scripts-and-their-roles)
  - [How to Run the Project](#how-to-run-the-project)
  - [Testing and Automation with Makefile](#testing-and-automation-with-makefile)
  - [Known Issues or Limitations](#known-issues-or-limitations)

---

## Project Overview

This submission solves the "Board Games or Bored Games" assignment using the BoardGameGeek dataset from Kaggle.  
It features a shell-based data processing and analytics pipeline for:

- Data quality checking (`empty_cells.sh`)
- Data cleaning and normalization (`preprocess.sh`)
- Automated analytics (popularity/correlation via `analysis.sh`)

All scripts use only Unix tools and follow best practices taught in CITS4407 lectures.

---



## Scripts and Their Roles

1. **empty_cells.sh**
   
	•	**Purpose**: Counts and reports the number of empty cells per column in a delimited text file.

	•	**Usage**:

```bash
./empty_cells.sh <input-file> <separator>
# Example:
./empty_cells.sh sample.txt ";"

```
2. **preprocess.sh**

**Cleans raw data:**

	•	Converts semicolons to tabs
	•	Converts CRLF to LF
	•	Fixes decimal commas to dots
	•	Removes non-ASCII characters
	•	Fills missing IDs
	•	Quotes “Mechanics” and “Domains” fields

    
**Usage:**
```bash
./preprocess.sh <input-file> > <output-clean-file>
# Example:
./preprocess.sh sample.txt > sample_clean.tsv
```

3. **analysis.sh**

Analyzes cleaned data to report:

	•	Most popular mechanic and domain
	•	Correlation between year/rating and    complexity/rating 

**Usage:**

```bash
./analysis.sh <clean-file>
# Example:
./analysis.sh sample_clean.tsv
```
4. **Makefile**

Automates pipeline steps and testing.

**Usage:**

Full pipeline: 

```bash
make all
```
Cleanup: 

```bash
make clean
```

Just the big dataset: 

```bash
make full
make analysis_full
```
---

## How to Run the Project

1. Ensure scripts are executable:

```bash
chmod +x *.sh
```

2.	Run all pipeline/test steps:

```bash
make all
```
3. Clean up intermediate files:

```bash
make clean
```

## Testing and Automation with Makefile

The Makefile provides convenient targets to automate:

	•	Data cleaning for all sample/test files
	•	Full analysis for each dataset
	•	Cleanup

## Known Issues or Limitations

	•	Assumes the header and column order match the assignment samples.

	•	“Mechanics” and “Domains” columns are always quoted for robustness—this is intentional.
    