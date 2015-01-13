---
title: "Region1CyanoLocations2014"
author: "Bryan Milstead"
date: "January 13, 2015"
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
* missing location data for ME
* check locations manually for distance >0
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
* Check which data (excluding blanks and standards) are missing locations
* Created NHDES_MissingLocation.csv & UNH_MissingLocation.csv



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





* produce KML file and view in google earth
* produce SHP file


#create KML file of location          
  kmlPoints(Loc, 
            kmlfile='Locations.kml', 
            name=paste("Location",Loc@data$Location), 
            description=paste("WBID",Loc@data$WBID),
            icon="http://google.com/mapfiles/kml/paddle/wht-diamond.png",
            kmlname="Locations",
            kmldescription="Region 1 CyanoMonitoring Locations")
#open file in google earth
  shell.exec('Locations.kml')
  
  
  nrow(WBID)  #227 locations
  length(unique(WBID$WBID))  #75 lakes
  
  plot(Lakes[Lakes@data$WB_ID%in%unique(WBID$WBID),])
  
  
  Lakes1<-Lakes[Lakes@data$WB_ID%in%unique(WBID$WBID),]
  a<-gCentroid(Lakes1,byid=TRUE,)
  

  
 


  
  windows(8,10)
  plot(NE)
  plot(Lakes1,add=TRUE,col='blue')
  plot(a,add=T,pch=16,col='red')
  
  plot(NE)
  plot(Lakes1,add=TRUE,col='blue')
  plot(Loc,add=T,pch=16,col='red')


