---
title: "Region1CyanoLocations2014"
author: "Bryan Milstead"
date: "March 4, 2015"
output: html_document
---
<!---
use these command instead of the knit icon if you want the data and work loaded into the R workspace
  library(knitr)
  knit('Data2014/Locations2014.rmd')

  -->


To Do List
-------------------------
* missing location data for ME
* check locations manually for distance >0
* Map locations and send to contacts for verifications

Introduction
-------------------------
During the summer of 2014 the New England states initiated a monitoring program for cyanobacteria in lakes.  Participants included state and tribal governments, local watershed associations, EPA Region 1, and the EPA Atlantic Ecology Division. 

The data have been standardized and are available here in .csv format (hint: right click on the link and choose “Save As” to save the file to your computer, otherwise, it will open in your browser): https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Data2014.csv?raw=true

The details of the data processing steps can be found here: https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Data2014.md

This document is available here: https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Locations2014.md

A KML file for view in Google Earth is available here (hint: right click on the link and choose “Save As” to save the file to your computer, otherwise, it will open in your browser): https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Locations.kml?raw=true

An R datafile with a the Locations in SpatialPointsDataframe format is available here (hint: right click on the link and choose “Save As” to save the file to your computer, otherwise, it will open in your browser): https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Locations.rda?raw=true

Data Definitions SpatialPointsDataFrame "Locations" in "Locations.rda" 
-------------------------

Field  | Units | Description
------------- | ------------- | -------------
**Longitude:**|(Decimal Degrees)|Longitude of Location
**Latitude:**|(Decimal Degrees)|Latitude of Location
**LocID:**|(Integer)|Unique identifier for location
**WBID:**|(Integer)|Unique identifier for closest lake to location
**Distance:**|(Meters)|Distance from Location to nearest lake

Data Sources
-------------------------
The field data, including location information, have been standardized and are available here in .csv format (hint: right click on the link and choose “Save As” to save the file to your computer, otherwise, it will open in your browser): https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Data2014.csv?raw=true

The details of the data processing steps and the data definitions can be found here: https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Data2014.md

This document is available here: https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Locations2014.md

Data Steps
-------------------------

* Download the data 
* Check which data (excluding blanks and standards) are missing locations
* Created NHDES_MissingLocation.csv & UNH_MissingLocation.csv















