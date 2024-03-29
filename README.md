# Leaks, Attribution, and Academic Research

## Overview

This repo includes all files needed to reproduce the paper "Leaks, Attribution, and Academic Research". This paper follows a reproduction Christopher Darnton's 2022 paper, "The Provenance Problem: Re-search Methods and Ethics in the Age of WikiLeaks." The paper explores research methods and publication trends in articles apparently referencing leaked classified documents in top international relations journals from 2010 - 2020.

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from Darnton's replication file.
-   `data/analysis_data` contains the cleaned datasets that were constructed.
-   `other` contains relevant literature, LLM statement, and sketches.
-   `paper` contains the files used to generate the paper, and replication, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to replicate, simulate, download, test, and clean data.

## Instructions

Run:

-   *Replication file from "The Provenance Problem: Re-search Methods and Ethics in the Age of WikiLeaks." must be downloaded from the Harvard Dataverse. Please follow detailed instructions in `scripts/01-download_data.R`*

-   `scripts/01-download_data.R` follow instructions to download the required data set then run to save file as .csv.
-   `scripts/02-data_cleaning.R` to clean all relevant data for producing paper.
-   `scripts/03-test_data.R` to test clean data sets.
-   `scripts/99-replications.R` (optional) to produce replicated graphs from Darnton's paper.


Run/Render:

-   `outputs/leaks_attribution_research.qmd` to see how graphs/tables were created and render paper to PDF format

## Statement on LLM usage

LLMS were not used in the writing, research, or computational aspects of this paper.
