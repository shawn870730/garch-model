# Financial Econometrics - GARCH Model Analysis

This repository contains the Matlab code and analysis for the GARCH model applied to the daily stock prices of the New York Times Company (ticker 'NYT') for the period 1985-2021.

## Introduction

This project is part of the Financial Econometrics course (Econ 724) at the University of Wisconsin-Madison. The aim is to analyze the volatility of stock returns using various GARCH models.

## Data Collection

The data used in this project consists of daily stock prices for the New York Times Company from January 1, 1985, to December 31, 2021. The data is sourced from Yahoo Finance.

## Models Implemented

1. **GARCH(1,1)**:
   - Implemented using Matlab's `garch` function.
   - Chosen based on lower AIC compared to other models.
   - Includes density plot of de-volatilized residuals.

2. **GARCH(2,3)**:
   - Although implemented, the coefficients of garch(1) and arch(3) were found not significant.

3. **GARCH(1,1) with Student's t-distribution**:
   - Estimated using the student t error distribution.
   - All coefficients significant, with a degree of freedom parameter around 4.6, indicating a fat-tailed distribution.

4. **GJR-GARCH Model**:
   - Incorporates leverage effect to account for asymmetry in volatility.
   - Negative shocks have a greater effect on conditional variance than positive shocks, consistent with the leverage effect.

## Results

The results from the Matlab code include:

- Estimated residuals and standard deviations using the GARCH(1,1) model.
- Density plots comparing the residuals to a normal distribution.
- Significant coefficients for the GARCH(1,1) with Student's t-distribution.
- Positive and significant leverage coefficient in the GJR-GARCH model, highlighting the leverage effect.

## Usage

To run the Matlab code, use the `garch_model.m` file. Ensure you have the necessary financial data for the specified period. The primary functions and their usage are documented within the Matlab script.
