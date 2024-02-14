# Starter folder

## Overview

This repo includes all files needed to reproduce my paper "Leaks, Attribution, and Academic Research". This paper follows a reproduction Christopher Darnton's 2022 paper, "The Provenance Problem: Re-search Methods and Ethics in the Age of WikiLeaks." The paper explores research methods and publication and trends in articles apparently referencing leaked classified documents in top international relations journals from 2010 - 2020.

To use this folder, click the green "Code" button", then "Download ZIP". Move the downloaded folder to where you want to work on your own computer, and then modify it to suit.

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from Darnton's replication file.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, and replication, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to replicate, simulate, download, test, and clean data.

## Instructions

Run:

-   `scripts/01-download_data.R` follow instructions to download the required data set then run to save file as .csv.
-   `scripts/02-data_cleaning.R` to clean all relevant data for producing paper.
-   `scripts/03-test_data.R` to test clean data sets.
-   `scripts/99-replications.R` (optional) to produce replicated graphs from Darnton's paper.

Run/Render:

-   `outputs/paper.qmd` to see how graphs/tables were created and render paper to PDF format

## Statement on LLM usage

LLMS were not used in the writing, research, or computational aspects of this paper.
