# Global Layoffs Analysis Project

## Overview

This project focuses on analysing global layoff data collected between 2020 and 2023 using MySQL. The objective was to clean, standardise, and analyse the dataset to identify trends in layoffs across companies, industries, countries, and time periods.

The project demonstrates the process of preparing raw data for analysis, performing exploratory data analysis (EDA), and extracting business insights using SQL.

Credits for the dataset and project inspiration go to Alex the Analyst


### Tools Used

* MySQL
* MySQL Workbench

### Project Objectives

The main goals of this project were:

## Data Cleaning

* Remove duplicate records
* Standardise inconsistent data formats and values
* Handle null and blank values
* Remove unnecessary columns
* Prepare the dataset for analysis

### Data Cleaning Process

The following steps were performed:

* Created a duplicate table to preserve the original raw dataset and perform cleaning safely.
* Used the `ROW_NUMBER()` window function with partitioning across all columns to identify duplicate records.
* Created a staging table to store row numbers and identify duplicate entries for removal.
* Removed duplicate records from the cleaned dataset.
* Standardised inconsistent values:
  - Removed unnecessary spaces using trimming functions.
  - Combined different variations of the same category (for example, Crypto, Crypto Currency, and CryptoCurrency were standardised into one value).
* Converted the date column from string format into a proper date format.
* Removed rows where both `total_laid_off` and `percentage_laid_off` contained null values.
* Removed the temporary row number column after cleaning was completed.

## Exploratory Data Analysis (EDA)

SQL queries were created to explore layoff trends across:

* Companies
* Industries
* Countries
* Company stages
* Time periods

## Key Findings

The analysis identified the following insights:

### Company Layoffs

* Companies such as Amazon, Google, Salesforce, and Microsoft experienced some of the highest layoffs.

### Industry Impact

* The consumer and retail industries experienced the largest number of layoffs, potentially influenced by economic changes following the COVID-19 pandemic.

### Geographic Trends

* The countries with the highest layoffs were:
  1. United States
  2. India
  3. Netherlands

### Yearly Trends

* 2022 recorded the highest number of layoffs within the dataset.
* 2023 showed continued layoffs, although the dataset only covered the beginning months of the year.

### Company Stage Analysis

* Post-IPO companies experienced the largest number of layoffs compared to other company stages.


## Additional Analysis

A rolling total of layoffs over time was calculated to identify changes in layoff trends.

Findings:

* Layoffs began increasing significantly during 2022.
* 2021 showed relatively lower layoff activity.
* The final months of 2022 and early 2023 showed a major increase in layoffs.


### Company Layoff Trends by Year

The companies with the highest layoffs each year were identified:

* 2020: Uber
* 2021: ByteDance
* 2022: Meta
* 2023: Google
