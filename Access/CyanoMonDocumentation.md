---
title: "cyanoMonDocumentation"
author: "Bryan"
date: "Monday, March 30, 2015"
output: html_document
---
<!---
use these command instead of the knit icon if you want the data and work loaded into the R workspace
  library(knitr)
    setwd("Access")
    knit('cyanoMonDocumentation.rmd')
  -->


To Do List
-------------------------

* Develop a method to assign unique identifiers that works with the phone app
* Build forms
* Add 2014 data
* Develop and test phone app

Background
-------------------------


* EPA region 1 is coordinating a Cyanobacteria Monitoring Progam for the six New England States (CT, MA, ME, NH, RI, & VT)
* Data collection initiated during the summer of 2014
* 2014 data have been collated and standardized
* For future data collection we need a relational database developed for data entry and archiving 
* The Database need to work with a Data Collection Phone App under development
* For now, the database will be created in MSAccess (cyanoMon.mdb)
* This document is available here: https://github.com/willbmisled/Reg1Cyano/blob/master/Access/cyanoMonDocumentation.md

Database Structure
-------------------------

* The five tables in the access database (cyanoMon.mdb) are described below:

![Relationships for cyanoMon.mdb](cyanoMonRelationships.jpg)

* **tblWaterbody** provides general information on the waterbody and assigns a unique identifier.  Ideally we will have this table populated before the field crews go out so that they can select the correct lake from a list.  The reality is that we will also need to be able to add lakes on the fly as new lakes are added to the sampling plan. There may be multiple stations for each waterbody.

Field  | Data Type | Description
------------- | ------------- | -------------
**waterbodyID**|AutoNumber|Primary Key for this table. Unique ID for the Waterbody
**waterbodyName**|Short Text|Name of the waterbody
**state**|Short Text|Combo Box ("CT"; "MA"; "ME"; "NH"; "RI"; "VT"): Two letter state abbreviations
**town**|Short Text|Text Box: Closest town to the lake
**WBID**|Long Integer|Text Box: EPA Waterbody Identifier
**otherWaterbodyID**|Short Text|Text Box: If the states or the samping organization have a unique identifier for the waterbody it can be added here.
**longitudeWB**|Double|Text Box: longitude in decimal degrees (WGS84) of the lake centroid
**latitudeWB**|Double|Text Box: latitude in decimal degrees (WGS84) of the lake centroid
**locationSourceWB**|Short Text|Combo Box ("WaterbodyDatabase"; "GPS"; "GoogleEarth"; "BingMaps"; "topoMap"): How was the location determined?
**commentWB**|Long Text| Text Box: Additional information or comments


* **tblStation** within each Waterbody there may be multiple stations. This table provides general information on the station.  There may be multiple samples taken from each station.

Field  | Data Type | Description
------------- | ------------- | -------------
**stationID**|AutoNumber|Primary Key for this table. Unique ID for the Station
**waterbodyID**|AutoNumber|Lookup primary Key from tblWaterbody: which lake?
**otherStationID**|Short Text|Text Box: If the states or the samping organization have a unique identifier for the station it can be added here.
**stationType**|Short Text|List Box/Radio Button ("NearShore"; "OffShore")| Location of the station in relation to the shore
**longitudeSta**|Double|Text Box: longitude in decimal degrees (WGS84) of the station
**latitudeSta**|Double|Text Box: latitude in decimal degrees (WGS84) of the station
**locationSourceSta**|Short Text|Combo Box ("WaterbodyDatabase"; "GPS"; "GoogleEarth"; "BingMaps"; "topoMap"): How was the location determined?
**commentStation**|Long Text| Text Box: Additional information or comments

* **tblSample** for each station within a waterbody there may be multiple sample events. This table provides general information on each sample event.  There may be multiple analysis events for each sample event.

Field  | Data Type | Description
------------- | ------------- | -------------
**sampleID**|AutoNumber|Primary Key for this table. Unique ID for the sample event
**stationID**|AutoNumber|Lookup primary Key from tblStation: where was the sample taken?
**sampleDate**|Short Date|Text Box: Date the sample was taken in format MM/DD/YYYY
**sampleTime**|Medium|Text Box: Time the sample was taken in format HH:MM AM/PM
**organization**|Short Text|Combo Box ("CRWA"; "CTDEEP"; "MEDEP"; "NHDES";"RIWW"; "UNH_CFB"; "VTDEC"): Name of the organization in charge of visit; if more than one choose the primary
**fieldCrew**|Short Text|Text Box: Names of the field crew separated by commas
**sampleMethod**|Short Text|Combo Box ("Integrated Sampler"): should be Integrated Sampler but other values can be added.
**sampleDepthM**|Integer|Combo Box (1; 3): Depth (meters) sample was taken.  Should be 1 or 3 meters but other values can be added.
**waterTempC**|Single|Text Box: Lake water temperature in Celsius
**weather**|Short Text|List Box ("Clear"; "Partly Cloudy"; "Overcast"; "Rain"): Limited choice descriptor of weather conditions 
**surfaceWaterCondition**|Short Text|List Box ("Calm"; "Ripples"; "Choppy"; "White Caps"): Limited choice descriptor of weather conditions 
**photoSample**|Yes/No|Check Box: where photos taken during sampling?
**commentSample**|Long Text| Text Box: Additional information or comments

* **tblAnalysis** for each sample taken there will be one or more analysis events. This table provides general information on each analysis event.  There may be multiple fluorometry readings for each analysis event.

Field  | Data Type | Description
------------- | ------------- | -------------
**analysisID**|AutoNumber|Primary Key for this table. Unique ID for the analysis event
**sampleID**|AutoNumber|Lookup primary Key from tblSample: analysis for which sample event?
**analysisDate**|Short Date|Text Box: Date the sample was analyzed in format MM/DD/YYYY
**analysisTime**|Medium|Text Box: Time the sample was analyzed in format HH:MM AM/PM
**analystName**|Short Text|Text Box: Name of primary person in charge of the analysis
**frozen**|Yes/No|Check Box: was sample frozen prior to analysis?
**filtered**|Yes/No|Check Box: was sample filtered prior to analysis?
**dilution**|Short Text|Combo Box ("1:1"; "1:5"; "1:10"): Default = 1 to 1 (not diluted); other choices are 1 to 5 and 1 to 10; other values can also be added.
**sampleTemperatureC**|Single|Text Box: sample temperature in Celsius at time of analysis
**photoAnalysis**|Yes/No|Check Box: where photos taken during analysis?
**commentAnalysis**|Long Text| Text Box: Additional information or comments

* **tblFluorometry** this table provides the fluorometry readings for each analysis.  There should be at least one reading each for phycocyanin and chlorophyll a.

Field  | Data Type | Description
------------- | ------------- | -------------
**fluorometryID**|AutoNumber|Primary Key for this table. Unique ID for the fluorometry reading
**analysisID**|AutoNumber|Lookup primary Key from tblAnalysis: fluorometry reading for which analysis event?
**parameter**|Short Text|List Box ("Chlorophyll"; "Phycocyanin"): which pigment was analyzed?
**valueUGL**|Single|Text Box: Fluorometry reading in ug/l
**fluorometerType**|Combo Box: ("Beagle"): this should be a Beagle but user can input other choices.
**commentFluorometry**|Long Text| Text Box: Additional information or comments














