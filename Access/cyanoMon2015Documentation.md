---
title: "cyanoMon2015Documentation"
author: "Bryan"
date: "May 18, 2015"
output: html_document
---
<!---
use these command instead of the knit icon if you want the data and work loaded into the R workspace
  library(knitr)
    setwd("Access")
    knit('cyanoMon2015Documentation.rmd')
  -->


Readme
-------------------------

This document is available here: https://github.com/willbmisled/Reg1Cyano/blob/master/Access/CyanoMonDocumentation.md

To Do List
-------------------------

* Build forms-with data validation steps
* Interface for Phone App
    - Make sure ID structure is the same between database and phoneApp

Question
-------------------------
* Do we remove the field "filtered"?
* Should we add table for lab results and ancillary data-toxins, nutrients, secchi, etc.?
* How do we keep track of what method was used to enter the data?
* Do we want to keep track of which Fluorometers are used (i.e, assign each unit a code)?
* Do we need to capture information on primary and secondary standards?
* How can we capture and archive the photos?


Changes for the 2015 database
-------------------------
**tblWaterbody**

* removed field "otherWaterbodyID"
* changed commentWB to format "Long Text" to allow for multiple comments

**tblStation**

* removed field "otherStationID"
* changed commentSta to format "Long Text" to allow for multiple comments
* renamed "stationLocation" to "stationDescription" to match phoneApp

**tblSample**

* added field "sampleRep" to register replicate samples: with default value "primary" and optional value "duplicate" 

**tblFluorometry** 

* table removed and fields added to tblAnalysis

**tblAnalysis**

* added fields from tblFluorometry
    - "parameter"
    - "fluorometerType"
    - "rep" renamed "analysisRep": with default value "primary" and optional value "duplicate"
    - "reading" renamed "valueUGL"
* fields that were not transferred from from tblFluorometry
    - fluorometryID
    - commentFluorometry
    - units

Phone App
-------------------------
* General Questions and Comments
    - will there be an instruction manual?
    - no indicator of whether table has been saved (updated or not) except on Station Table; could the text color for "Update DB" change depending on update status (red=unsaved items; green=everything up to date)
    - no warning if you leave a page without saving (updating)
    - date and time selector widgets difficult to use.
    - selection button on drop down list very small.
    - yes/no dropdowns have phycocyanin and chl. as choices instead of "yes" & "no"; I see what is happening.  Whenever you choose a dropdown it stays on the screen.  When you go to another dropdown it writes over the first but both values are still visible.
    - dilution dropdown 
    - if you select "update DB" and there are unfilled fields it returns you to the missing field but erases other fields. 
    - temperature fields (sample & analysis) auto adds a decimal place so 21 becomes 2.1
    - How can we capture the email and phone number for data entered by phoneApp?

* Welcome Screen:
    - how are the name, email, phone, & org saved and linked to the data tables?
    - can the app remember this info and reuse it?
    - Organization should be a combo box that allows for new organizations to be added and remembered.
    - "new lake" & "existing lake" button only visible in portrait mode.  This should be fixed or the app could be locked in portrait.
    
* New Lake Screen:
    - Apparently this will be used to both add new waterbodies and select known waterbodies that are already in the app.  Somewhat confusing.
    - on screen keyboard blocks view of data entry boxes.
    - The abbreviation "WBID" (GENERATE WBID button) is a field name in the database.
    - If you start adding data then cancel when you return the data entered are not erased.  
    - can "generate WBID" without adding the lake name or date.
    
* waterbody screen
    - Include NY and Ontario in State should be a combo box-allowing other states beside the known 6.  Ontario and NY should be included also.
    
* station:
    - RI out of range on longitude (-71.4)
    
* sample screen
    - add "today" to sampleDate widget
    - add "now" to sampleTime widget
    - would be nice to be able to choose a station ID directly from this screen instead of having to pass through waterbody & station pages first.  If a person goes to a lake they will likely want to collect samples from more than 1 station at each visit.  
    - Add field "fieldCrew" to tblSample
    - rename field "time" to "sampleTime" in tblSample
    - Add field "sampleRep" to tblSample: with default value "primary" and optional value "duplicate"
    
* Analysis Screen:
    - text slightly garbled for "Parameter" drop down
    - Add field "analysisRep" to tblAnalysis: with default value "primary" and optional value "duplicate"
        
* submit page
    - should be able to submit more than one lake at a time- perhaps a checklist of lakeIDs with a status indicator showing whether they have been submitted before or not.
    - can submit the same data multiple times-data arrives with the same subject line and the same file names.
    - why are we given so many choices on how to send the data (twitter-facebook-etc)?
    - email address for submissions can be changed.  Is this a good idea?
    - does not send "waterbody" table

Background
-------------------------

* EPA region 1 is coordinating a Cyanobacteria Monitoring Progam for the six New England States (CT, MA, ME, NH, RI, & VT)
* Data collection initiated during the summer of 2014
* 2014 data have been collated and standardized
* For future data collection we need a relational database developed for data entry and archiving 
* The Database needs to work with a Data Collection Phone App under development
* The database will be created in MSAccess (cyanoMon2015.mdb)


Database Structure
-------------------------

* The relationships between the tables are shown in the figure below

![Relationships for cyanoMon2015.mdb](cyanoMon2015Relationships.jpg)

* Each table in the access database (cyanoMon2015.mdb) is described and data
definitions are given below

**tblOrganization** provides contact information for each organization contributing to the monitoring.

Field  | Data Type | Description
------------- | ------------- | -------------
**orgID**|Short Text|combo Box(AED, CRWA, CTDEEP, MEDEP, NHDES, RIWW, UNH, VTDEC). Primary Key for this table. Unique ID for the Organization. Acronym for orgName 
**orgName**|Short Text|Combo Box ("EPA Atlantic Ecology Division", "Charles River Watershed Association", "CT Department  of Environmental Protection", "ME Department of Environmental Protection", "NH Department of Environmental Services", "RI Watershed Watch", "University of NH Center for Freshawater Biology", "VT Department of Environmental Conservation")
**contact**|Short Text|Name of the person in charge of data steward for the organization. Who can be contacted with questions about the data?
**email**|Short Text|Email address of contact person (data steward).
**phone**|Short Text|Phone number (xxx-xxx-xxxx) of contact person (data steward).

**tblWaterbody** provides general information on the waterbody and assigns a unique identifier.  Ideally we will have this table populated before the field crews go out so that they can select the correct lake from a list.  The reality is that we will also need to be able to add lakes on the fly as new lakes are added to the sampling plan. There may be multiple stations for each waterbody.

Field  | Data Type | Description
------------- | ------------- | -------------
**waterbodyID**|Short Text|Primary Key for this table. Unique ID for the Waterbody. Can either be entered by the users or or assigned by the phoneApp.
**orgID**|Short Text|Lookup primary Key from tblOrganization
**waterbodyName**|Short Text|Name of the waterbody
**state**|Short Text|Combo Box ("CT"; "MA"; "ME"; "NH"; "RI"; "VT"): Two letter state abbreviations
**town**|Short Text|Text Box: Closest town to the lake
**WBID**|Long Integer|Text Box: EPA Waterbody Identifier; Not in phoneApp.  This field will be populated by the database administrator.
**longitudeWB**|Double|Text Box: longitude in decimal degrees (WGS84) of the lake centroid.  This field will be populated by the database administrator.
**latitudeWB**|Double|Text Box: latitude in decimal degrees (WGS84) of the lake centroid. This field will be populated by the database administrator.
**locationSourceWB**|Short Text|Combo Box ("WaterbodyDatabase"; "GPS"; "GoogleEarth"; "BingMaps"; "topoMap"): How was the location determined? This field will be populated by the database administrator.
**commentWB**|Long Text| Text Box: Additional information or comments

**tblStation** within each Waterbody there may be multiple stations. This table provides general information on the station.  There may be multiple samples taken from each station.

Field  | Data Type | Description
------------- | ------------- | -------------
**stationID**|Short Text|Primary Key for this table. Unique ID for the Station
**waterbodyID**|Short Text|Lookup primary Key from tblWaterbody
**stationDescription**|Short Text|Text description of the station location
**stationType**|Short Text|List Box/Radio Button ("nearShore"; "offShore";"other"): Location of the station in relation to the shore;for special situations choose other and add notes in field "commentStation"
**longitudeSta**|Double|Text Box: longitude in decimal degrees (WGS84) of the station.  Miniumum of 4 decimal places; 6 decimal places prefered.
**latitudeSta**|Double|Text Box: latitude in decimal degrees (WGS84) of the station.  Miniumum of 4 decimal places; 6 decimal places prefered.
**locationSourceSta**|Short Text|Combo Box ("WaterbodyDatabase"; "GPS"; "GoogleEarth"; "BingMaps"; "topoMap"): How was the location determined?
**commentStation**|Long Text| Text Box: Additional information or comments

**tblSample** for each station within a waterbody there may be multiple sample events. This table provides general information on each sample event.  There may be multiple analysis events for each sample event.

Field  | Data Type | Description
------------- | ------------- | -------------
**sampleID**|Short Text|Primary Key for this table. Unique ID for the sample event
**stationID**|Short Text|Lookup primary Key from tblStation: where was the sample taken?
**sampleDate**|Short Date|Text Box: Date the sample was taken in format MM/DD/YYYY
**sampleTime**|Medium Time|Text Box: Time the sample was taken in format HH:MM AM/PM
**organization**|Short Text|Combo Box ("CRWA"; "CTDEEP"; "MEDEP"; "NHDES";"RIWW"; "UNH_CFB"; "VTDEC"): Name of the organization in charge of visit; if more than one choose the primary
**fieldCrew**|Short Text|Text Box: Names of the field crew separated by commas
**sampleMethod**|Short Text|Combo Box ("Integrated Sampler"): should be Integrated Sampler but other values can be added.
**sampleRep**|Short Text|Option to choose between "primary" (default) and "duplicate". Note: a sample rep should be a completely new sample not just a subsample from the original sample.
**sampleDepthM**|Integer|Combo Box (1; 3): Depth (meters) sample was taken.  Should be 1 or 3 meters but other values can be added.
**waterTempC**|Single|Text Box: Lake water temperature in Celsius
**weather**|Short Text|List Box ("Clear"; "Partly Cloudy"; "Overcast"; "Rain"): Limited choice descriptor of weather conditions 
**surfaceWaterCondition**|Short Text|List Box ("Calm"; "Ripples"; "Choppy"; "White Caps"): Limited choice descriptor of weather conditions 
**photoSample**|Yes/No|Check Box: where photos taken during sampling?
**commentSample**|Long Text| Text Box: Additional information or comments

**tblAnalysis** for each sample taken there will be one or more analysis events. This table provides general information on each analysis event.  

Field  | Data Type | Description
------------- | ------------- | -------------
**analysisID**|Short Text|Primary Key for this table. Unique ID for the analysis event
**sampleID**|Short Text|Lookup primary Key from tblSample: analysis for which sample event?
**analysisDate**|Short Date|Text Box: Date the sample was analyzed in format MM/DD/YYYY
**analystName**|Short Text|Text Box: Name of primary person in charge of the analysis
**frozen**|Yes/No|Check Box: was sample frozen prior to analysis?
**filtered**|Yes/No|Check Box: was sample filtered prior to analysis?
**dilution**|Short Text|Combo Box ("1:1"; "1:5"; "1:10"): Default = 1 to 1 (not diluted); other choices are 1 to 5 and 1 to 10; other values can also be added.
**sampleTemperatureC**|Single|Text Box: sample temperature in Celsius at time of analysis
**parameter**|Short Text|List Box/Radio Button ("phycocyanin"; "chlorophyll")|
**valueUGL**|Single|Text Box: Fluorometry reading 
**analysisRep**|Short Text|Option to choose between "primary" (default) and "duplicate". Note: this should be a reading of a new aliquot from the sample; not a duplicate reading of a previously read aliquot.
**fluorometerType**|Combo Box: ("Beagle"): this should be a Beagle but user can input other choices.
**photoAnalysis**|Yes/No|Check Box: where photos taken during analysis?
**commentAnalysis**|Long Text| Text Box: Additional information or comments















