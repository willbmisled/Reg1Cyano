---
title: "Region1CyanoLocations2014"
author: "Bryan Milstead"
date: "Monday, December 31, 2014"
output: html_document
---
<!---
use these command instead of the knit icon if you want the data and work loaded into the R workspace
  library(knitr)
      a<-getwd()
        if(substr(a,nchar(a)-8,nchar(a))=='Reg1Cyano')  {setwd('./Data2014/')
          } else {if(substr(a,nchar(a)-7,nchar(a))!='Reg1Cyano') print('WARNING: Wrong Working Directory')}
  knit('Locations2014.rmd')
-->
To Do List
-------------------------
* Map locations and send to contacts for verifications
* Add WBIDs


Introduction
-------------------------
During the summer of 2014 the New England states initiated a monitoring program for cyanobacteria in lakes.  Participants included state and tribal governments, local watershed associations, EPA Region 1, and the EPA Atlantic Ecology Division. 

The task now is to collate all the data into a standardized format.  Below are the data processing steps used and some questions to be resolved for each data contributor.

A simple excel template for data entry is available here: https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Region1CyanobacteriaDataEntryTemplate.xls?raw=true

This document is available here: https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Data2014.md

The details of all data processing steps including notes and rcode are available here: https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Data2014.Rmd

The collated dataset is available here in .csv format (hint: right click on the link and choose “Save As” to save the file to your computer, otherwise, it will open in your browser): https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Data2014.csv?raw=true
