# forecasting-US-election-2020

This repo is dedicated for the prediction of the 2020 US presidential election results. We use Multi-Regression Post-Stratification technique to build a model on the available survey data and use the population census data to construct demographic cells and find the estimates for each cell. In the end, we weigh the relevant cell and arrive at an estimate of the proportion of US population would vote for Donald Trump/Joe Biden.

The study is built upon two data sets:
1. Survey data - collected by the Voter Study Group. Specifinally, ns20200625 is used to construct the model.
2. Census data - collected by the IPUMS USA, University of Minnesota. Variables are selected accordingly. The name of the data set saved will differ from person to person. In our case, our data is saved as usa_00001.

Thanks to their diligent work on collecting massive data sets. 

Sections included in this repo:
1. R Script: contain all the relevant cleaning code and the code for reproducing our ourput pdf.
2. Output: contain the output pdf for the report and the cleaned datasets.