# CITS4407-Assignment-2

**Author:** Manas Rawat  
**Unit:** CITS4407 Open Source Tools and Scripting  
**Semester:** 1, 2025  
**UWA Student ID:** 24004729

---

## Table of Contents

- [CITS4407-Assignment-2](#cits4407-assignment-2)
  - [Table of Contents](#table-of-contents)
  - [File Structure](#file-structure)
  - [Project Overview](#project-overview)
  - [Scripts and Their Roles](#scripts-and-their-roles)
  - [How to Run the Project](#how-to-run-the-project)
  - [Testing and Automation with Makefile](#testing-and-automation-with-makefile)
  - [Known Issues or Limitations](#known-issues-or-limitations)

---
## File Structure

        CITS4407-Assignment-2/
        │
        ├── .gitignore
        ├── Makefile
        ├── README.md
        ├── analysis
        ├── empty_cells
        ├── preprocess
        │
        ├── sampleFiles/
        │   ├── bgg_dataset_clean.tsv
        │   ├── bgg_dataset.txt
        │   ├── sample_clean.tsv
        │   ├── sample.txt
        │   ├── sample1_clean.tsv
        │   ├── sample1.txt
        │   ├── tiny_sample_clean.tsv
        │   ├── tiny_sample.txt
        │   ├── tiny_sample.xlsx
        │

---

## Project Overview

The data used in this submission is the BoardGameGeek dataset from Kaggle to resolve the assignment “Board Games or Bored Games.”  
There is a shell-based way to process and analyze data in the pipeline.


- Data quality checking (`empty_cells`)
- Data cleaning and normalization (`preprocess`)
- Automated analytics (popularity/correlation via `analysis`)



---



## Scripts and Their Roles

1. **empty_cells**
   
	•	**Purpose**: Counts and reports the number of empty cells per column in a delimited text file.

	•	**Usage**:

```bash
./empty_cells <input-file> <separator>
# Example:
./empty_cells sample.txt ";"

```
2. **preprocess**

**Cleans raw data:**

	•	Converts semicolons to tabs
	•	Converts CRLF to LF
	•	Fixes decimal commas to dots
	•	Removes non-ASCII characters
	•	Fills missing IDs
	•	Quotes “Mechanics” and “Domains” fields

    
**Usage:**
```bash
./preprocess <input-file> > <output-clean-file>
# Example:
./preprocess sample.txt > sample_clean.tsv
```

3. **analysis**

Analyzes cleaned data to report:

	•	Most popular mechanic and domain
	•	Correlation between year/rating and    complexity/rating 

**Usage:**

```bash
./analysis <clean-file>
# Example:
./analysis sample_clean.tsv
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
---

## Testing and Automation with Makefile

The Makefile provides convenient targets to automate:

	•	Data cleaning for all sample/test files
	•	Full analysis for each dataset
	•	Cleanup

---

## Known Issues or Limitations

	•	Assumes the header and column order match the assignment samples.

	•	“Mechanics” and “Domains” columns are always quoted for robustness—this is intentional.
    
---    