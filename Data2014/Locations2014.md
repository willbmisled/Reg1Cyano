---
title: "Region1CyanoLocations2014"
author: "Bryan Milstead"
date: "March 18, 2015"
output: html_document
---
<!---
use these command instead of the knit icon if you want the data and work loaded into the R workspace
  library(knitr)
    setwd("Data2014")
    knit('Locations2014.rmd')
  -->


To Do List
-------------------------
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



* Keep only the unique long lat data 
* Create a SpatialPointsDataFrame



* Get MRB1_WBIDLakes from the WaterbodyDatabase.mdb
* Reproject to WGS84
* Fix holes (just in case)
* Cache this XXX



* Find the closest lake to each point
* First buffer the points by 1000 meters
* Use Over to select lakes within the buffer
* Use gDistance to find closest lake to each point
* If no lakes are found iteratively, increase the buffer distance up to 50km.
* Cache this XXX



* Create KML and SHP files of locations



* create an output file to check locations and location information
* save as 'tempLocations.csv'



* tempLocations.csv manually reviewed in excel
* Locations.kml verified in Google Earth
  - shell.exec('Locations.kml')
* names checked
* LocIDNew field added to aggregrate Sites with multiple location observations
* siteDescriptions simplified-manually.
* file resaved as tempLocations1.csv
* locations with distances to WBID greater than 20m verified in ArcGIS & GE
* LocID=11 Lon/Lat changed from -73.078158 / 45.340375; moved to offshore Phillpsburg
  - shell.exec('Locations.mxd')
* check that each there is only one siteDescription for each LocIDNew
* check that each there is only one WBID for each LocIDNew
* get unique LocIDNew information
* rename Lon/Lat 'Lon_LocIDNew' & 'Lat_LocIDNew'
* add WBID centroids 'Lon_WBID' & 'Lat_WBID'
* add WBID Centroids for Charles River sites (no WBID) (estimated from GE)
* make final locations files
  - "LocIDNew" a SpatialPointDataFrame with the unique aggregated locations and site information
  - "LocIDNew.kml" kml file of the locations
  - "LocIDNew.shp" shapefile of the locations  
  - "LocID2LocIDNew" crosswalk of the information in in LocIDNew to the original LocID in Data2014
* save data as Locations.rda



