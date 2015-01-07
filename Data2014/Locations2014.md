---
title: "Region1CyanoLocations2014"
author: "Bryan Milstead"
date: "January 7, 2015"
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

The data have been standardized and are available here in .csv format (hint: right click on the link and choose “Save As” to save the file to your computer, otherwise, it will open in your browser): https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Data2014.csv?raw=true

The details of the data processing steps can be found here: https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Data2014.md

This document is available here: https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Locations2014.md

Data Sources
-------------------------
The field data, including location information, have been standardized and are available here in .csv format (hint: right click on the link and choose “Save As” to save the file to your computer, otherwise, it will open in your browser): https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Data2014.csv?raw=true

The details of the data processing steps and the data definitions can be found here: https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Data2014.md

This document is available here: https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Locations2014.md

Data Steps
-------------------------
* Download the data 
* Keep only the unique long lat data 
* Add a unique identifier "Location" 
* Create a SpatialPointsDataFrame



* Get MRB1_WBIDLakes from the WaterbodyDatabase.mdb
* Reproject to WGS84
* Fix holes (just in case)


* Find the closest lake to each point
* First buffer the points by 1000 meters
* Use Over to select lakes within the buffer
* Use gDistance to find closest lake to each point
* If no lakes are found iteratively increase the buffer distance up to 50km.



Data2014[which(Data2014$Longitude==-71.63140),c('SiteID','WaterbodyName','SampleLocation','Latitude','Longitude')]
Data2014[which(Data2014$Latitude==40.427400),]

Loc@data[185,]

Change Latitude= 40.4274 to 41.4274 

-71.6314  40.427400° -71.631400°

a<-Loc@data$WBID==Loc@data$WBID
Loc@data[Loc@data$WBID!=Loc@data$WBID,] 

* produce KML file and view in google earth
* produce SHP file

writeOGR(Loc,getwd(),'Locations', driver="ESRI Shapefile")


plotKML(Loc["WBID"])


