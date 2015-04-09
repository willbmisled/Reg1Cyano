---
title: "buildAccessDB"
author: "Bryan"
date: "April 09, 2015"
output: html_document
---

<!---
use these command instead of the knit icon if you want the data and work loaded into the R workspace
  library(knitr)
    setwd("Access")
    knit('buildAccessDB.rmd')
  -->
  


To Do List
-------------------------

* Develop a method to assign unique identifiers that works with the phone app
* Build forms
* Add 2014 data
* Develop and test phone app
* reassign values for stationType (tblStation) to "nearShore" and "offShore"

Background
-------------------------

* EPA region 1 is coordinating a Cyanobacteria Monitoring Progam for the six New England States (CT, MA, ME, NH, RI, & VT)
* Data collection initiated during the summer of 2014
* 2014 data have been collated and standardized: https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Data2014.md
* 2014 locations have been verified: https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Locations2014.md
* A MSaccess database has been developed: https://github.com/willbmisled/Reg1Cyano/blob/master/Access/cyanoMonDocumentation.md
* OBJECTIVE: add the 2014 locations and data to cyanoMon.mdb

Datasteps
-------------------------

* Get data
* Keep samples only (eliminate blanks and standards)
* Merge tablular (df "Data") and location (df "LocID2LocIDNEW") data for Lakes
* Check that all data have locations-yes
* Rename fields to match cyanoMon.mdb (Old:New)
    - WaterbodyName:waterbodyName
    - State:state
    - Lon_DataID:longitudeData
    - Lat_DataID:latitudeData
    - Lon_LocIDNew:longitudeSta
    - Lat_LocIDNew:latitudeSta
    - GPSType:locationSourceSta
    - SampleLocation:stationType



**build tblWaterbody**

* Assign a unique waterbodyID to each lake-this will be the primary Key for tblWaterbody. Varies by Organization:
    - CRWA, CTDEEP, RIWW,VTDEC: Organization + SiteID
    - MEDEP: "MIDAS" + SiteID
    - NHDES: Organization + WaterbodyName
    - UNH_CFB & VTDEC: "WBID" + WBID
* Assign a otherWaterbodyID to each lake. Varies by Organization: 
    - CRWA, CTDEEP, RIWW,VTDEC: SiteID
    - VTDEC, UNH_CFB: NA #no ID given
    - NHDES: Organization + WaterbodyName #waterbody names are numeric IDs
* Make sure all waterbodyNames are consistently spelled
    - MIDAS_5408  Webber==Weber pond
    - MIDAS_5172  Unity==Unity Pond
* add missing lake names
    - VTDEC: lake champlain
    - NHDES: names manually extracted from "NHDES_Locations.csv" saved as "NHDES_waterbodyNames.csv" then added to DF "WB"
* add town==NA as a placeholder
* add field "locationSourceWB"
    - No WBID=='Google Earth
    - With WBID =='MRB1_WBIDLakes'
* extract commentWB and commentSta for siteComment
* Get unique values for c("waterbodyID","waterbodyName","state","town","WBID","otherWaterbodyID","LongitudeWB","LatitudeWB","locationSourceWB","commentWB")
* check to make sure the waterbodyID is unique and consistent



**build tblStation**

* stationID: unique identifier for tblStation-combination of LocIDNew and stationType 
* Assign otherStationID to each station within each lake. Varies by Organization:
    - CRWA,MEDEP:  SiteLocation
    - CTDEEP,RIWW,UNH_CFB,: NA
    - NHDES,VTDEC: SiteID
* stationLocation-varies by organization
    - CRWA,CTDEEP,RIWW,UNH_CFB,NHDES:  siteLocation
    - MEDEP,VTDEC: NA
* stationType: field "sampleLocation" renamed "stationType" above Okay for now but will need to reassign values to "nearShore" and "offShore"
* Get unique values for c("stationID","waterbodyID","otherStationID","stationLocation","stationType","LongitudeSta","LatitudeSta","locationSourceSta","commentSta")
* check to make sure the waterbodyID is unique and consistent




**build tblSample**

* add formatted sample and analysis dates and times.
* Rename fields to match cyanoMon.mdb (Old:New)
    - Organization:organization
    - NameOfSamplers:fieldCrew
    - SampleMethod:sampleMethod
    - Depth:sampleDepthM
    - WeatherConditions:weather
    - Photos:photoSample
* Add placeholder fields
    - waterTempC
    - surfaceWaterCondition
    - commentSample
* Get unique values for c("stationID","sampleDate","sampleTime","organization","fieldCrew","sampleMethod","sampleDepthM","waterTempC","weather","surfaceWaterCondition","photoSample","commentSample")
* sampleID: create sampleID as 1:nrow(tblSample)
* check to make sure the sampleID is unique and consistent
* add sampleID to df Data so it can used in the next table
 




table(Data$Fluorometer,useNA='ifany')






