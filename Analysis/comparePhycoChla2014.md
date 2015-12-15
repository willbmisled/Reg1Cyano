---
title: "comparePhycoChla2014"
author: "Bryan Milstead"
date: "November 6, 2015"
output: html_document
---
<!---
use these command instead of the knit icon if you want the data and work loaded into the R workspace
  library(knitr)
  setwd('Analysis')
  knit('comparePhycoChla2014')
  -->

To Do List
-------------------------
* everything



Introduction
-------------------------

The goal is to compare the values of chla and phycocyanin.
The expectation is that there should be a strong linear relationship (log log) between the two.

Data 
-------------------------

* get data from cyanoMon2014.mdb
* see CyanoMonDocumentation.Rmd



* Data Defintions

Field  | Data Type | Description
------------- | ------------- | -------------
**waterbodyID**|Short Text|Primary Key for this table. Unique ID for the Waterbody.  Can either be entered by the users or will **stationID**|Short Text|Primary Key for this table. Unique ID for the Station
**sampleID**|AutoNumber|Primary Key for this table. Unique ID for the sample event
**sampleDate**|Short Date|Text Box: Date the sample was taken in format MM/DD/YYYY
**organization**|Short Text|Combo Box ("CRWA"; "CTDEEP"; "MEDEP"; "NHDES";"RIWW"; "UNH_CFB"; "VTDEC"): Name of the organization in charge of visit; if more than one choose the primary
**sampleMethod**|Short Text|Combo Box ("Integrated Sampler"): should be Integrated Sampler but other values can be added.
**sampleDepthM**|Integer|Combo Box (1; 3): Depth (meters) sample was taken.  Should be 1 or 3 meters but other values can be added.
**analysisID**|AutoNumber|Primary Key for this table. Unique ID for the analysis event
**analysisDate**|Short Date|Text Box: Date the sample was analyzed in format MM/DD/YYYY
**frozen**|Yes/No|Check Box: was sample frozen prior to analysis?
**filtered**|Yes/No|Check Box: was sample filtered prior to analysis?
**parameter**|Short Text|List Box/Radio Button ("nearShore"; "offShore";"other")|
**reading**|Single|Text Box: Fluorometry reading 
**units**|Short Text|List Box/Radio Button ("ug/l"; "RFU"): units of the fluorometry reading.
**rep**|Integer|replicate number for multiple readings from a sample
**fluorometerType**|Combo Box: ("Beagle"): this should be a Beagle but user can input other choices.

Analysis Dataset
-------------------------

* Get means for fluorometry readings to eliminate reps and duplicate; aggregate by c('analysisID','parameter','units','fluorometerType')



* merge Chla and Phycocyanin readings by c('analysisID','units','fluorometerType')
* merge back to main dataset





