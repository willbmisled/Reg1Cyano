---
title: "Analysis"
author: "Bryan Milstead"
date: "March 4, 2015"
output: html_document
---
<!---
use these command instead of the knit icon if you want the data and work loaded into the R workspace
  library(knitr)
  setwd('Analysis')
  knit('Analysis20150115.rmd')
  -->

To Do List
-------------------------
* everything

Introduction
-------------------------
During the summer of 2014 the New England states initiated a monitoring program for cyanobacteria in lakes.  Participants included state and tribal governments, local watershed associations, EPA Region 1, and the EPA Atlantic Ecology Division. 

The task now is to collate all the data into a standardized format.  Below are the data processing steps used and some questions to be resolved for each data contributor.

A simple excel template for data entry is available here: https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Region1CyanobacteriaDataEntryTemplate.xls?raw=true

This document is available here: https://github.com/willbmisled/Reg1Cyano/blob/master/Analysis/Analsysis.md

The details of all data processing steps including notes and rcode are available here: https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Data2014.Rmd

The collated dataset is available here in .csv format (hint: right click on the link and choose “Save As” to save the file to your computer, otherwise, it will open in your browser): https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Data2014.csv?raw=true

A document showing how the locations and WBID's were defined and where to download a KML file of the locations can be found here: https://github.com/willbmisled/Reg1Cyano/blob/master/Data2014/Locations2014.md  

Analysis
-------------------------

* Get the data and match it to the locations
* remove the blanks and calibration standards
* Delete unnecessary fields and reorder.



  






Data Definitions
-------------------------

Data.frame "Cyano" has 4500 observations

Field  | Units | Description
------------- | ------------- | -------------
**ID:**|(integer)|Unique Identifier for each observation
**Organization:**|(text)|Name of the organization responsible for collecting the samples-e.g. Vermont DEC
**State:**|(lookup)|Two letter state code for site
**YourName:**|(text)|Name of the person entering the data
**SiteID:**|(text)|site ID from the Organization collecting the data (if they have one)
**WaterbodyName:**|(text)|Name of the sampled lake.
**SiteLocation:**|(text)|Some organizations have site names within a lake.
**SampleLocation:**|(lookup)|Where (in the lake) was the sample collected followed by the replicate number? WithinLake=WL1, WL2, or WL3; ShoreSide=SS1, SS2, SS3; Can also add Calibration or Blank for validation readings or Other.
**SampleYear:**|(YYYY)|Year sample was collected in format YYYY (e.g., 2014)
**SampleMonth:**|(MM)|Month sample was collected in integer format (e.g., months 1 to 12 )
**SampleDay:**|(DD)|Day sample was collected in integer format (e.g., day 1 to 31 )
**SampleHour:**|(HH)|Hour sample was taken in 24 hour format
**SampleMinutes:**|(MM)|Minute sample was taken in integer format
**NameOfSamplers:**|(text)|Names of the field crew separated by commas.
**WeatherConditions:**|(text)|General Weather conditions separated by commas.  E.g., Cloudy, Windy, Cold
**SampleMethod:**|(lookup)|How was the sample collected? Grab = Grab sample for surface blooms; Composite =Composite; Integrated = Integrated tube sample; Validation = Use this for Blanks and Calibration Standards; Other = give details in the comments section.
**Depth:**|(integer)|Within Lake samples are at 3m and Shoreside are at 1m.  If samples taken at different depths not the depth here and enter details in the comments section.  Leave blank for standards and blanks.
**Filtered:**|(TRUE/FALSE)|Was the sample filtered?
**Frozen:**|(TRUE/FALSE)|Was the sample frozen?
**Parameter:**|(lookup)|Phycocyanin or Chlorophyll?
**Value:**|(decimal)|Reading from the fluorometer
**Units:**|(lookup)|What were the units recorded.  If not "RFU" or "µ/L" flag the entry and add comment with the units used. 
**Rep:**|(integer)|If you made more than one measurement per sample or took more than one sample per site assign a replicate number to each observations and add notes in the comment field.
**Fluorometer:**|(lookup)|Type of fluorometer used?
**AnalysisYear:**|(YYYY)|Year sample was analyzed in format YYYY (e.g., 2014)
**AnalysisMonth:**|(MM)|Month sample was analyzed in integer format (e.g., months 1 to 12 )
**AnalysisDay:**|(DD)|Day sample was analyzed in integer format (e.g., day 1 to 31 )
**AnalysisHour:**|(HH)|Hour sample was analyzed in 24 hour format
**AnalysisMinutes:**|(MM)|Minute sample was analyzed in integer format
**GPSType:**|(text)|How was the location determined.  GPS (type), map, or google?
**Photos:**|(TRUE/FALSE)|Where photos taken?
**LocIDNew:**|(integer)|Unique Identifier for the Location.  See "Locations2014.rmd"
**Lon_LocIDNew**|(Decimal Degrees)|Longitude of the sample site identified by "LocIDNew"
**Lat_LocIDNew**|(Decimal Degrees)|Latitude of the sample site identified by "LocIDNew"
**WBID:**|(integer)|Unique Identifier for the Lake from the "WaterbodyDatabase.mdb".  See "Locations2014.rmd"
**Lon_WBID**|(Decimal Degrees)|Longitude of the centroid for the Lake identified by "WBID"
**Lat_WBID**|(Decimal Degrees)|Latitude of the centroid for the Lake identified by "WBID"
**Flag:**|(TRUE/FALSE)|Add a flag for any data line that needs further validation or processing
**Comments:**|(text)|Add details of flags or any notes about the data line or sample.

Decisions
-------------------------

* Restrict analysis to samples read on Cyano$Fluorometer=="Beagle"

```r
  table(Cyano$Fluorometer,useNA='ifany')
```

```
## 
## Beagle Turner 
##   3348   1152
```

* RFU vs ug/l:  Phycocyanin and Chlorophyll were read as either ug/l or as RFU.  We should probably limit the data Cyano$Units=='ug/l'

```r
  table(Cyano$Parameter,Cyano$Units,useNA='ifany')
```

```
##              
##                RFU ug/l
##   Chlorophyll  508 1710
##   Phycocyanin  574 1708
```

* How do we deal with multiple observations per lake in space?

```r
  table(Cyano$SampleLocation,Cyano$Parameter,useNA='ifany')
```

```
##        
##         Chlorophyll Phycocyanin
##   Other         112         112
##   SS1           518         530
##   SS10            0           1
##   SS11            0           1
##   SS2           156         158
##   SS3            28          30
##   SS4             0           2
##   SS5             0           2
##   SS6             0           2
##   SS7             0           2
##   SS8             0           2
##   SS9             0           2
##   SSC             9          10
##   WL1           695         756
##   WL2           287         286
##   WL3           269         268
##   WL4            41          40
##   WL5             1           0
##   WL6             1           0
##   WL7             1           0
##   WL8             1           0
##   WLC            29          30
##   <NA>           70          48
```

* How do we deal with multiple observations per lake in time?


* How do we deal with different depths?

```r
  table(Cyano$Depth,Cyano$Parameter,useNA='ifany')
```

```
##          
##           Chlorophyll Phycocyanin
##   0               137         135
##   0.5              16          16
##   1               732         722
##   1.1               8           8
##   1.2              14          14
##   1.5              16          16
##   1.6               4           4
##   10                3           3
##   11                3           3
##   12                3           3
##   13                3           3
##   14                3           3
##   15                3           3
##   2                19          23
##   3              1105        1145
##   4                 6           6
##   4.11              2           2
##   4.27              3           3
##   4.5               6           6
##   5                18          18
##   6                 6           6
##   6.5               6           6
##   7                11          11
##   7.5              15          15
##   7.8               9           9
##   8                 6           6
##   8.27              3           3
##   8.37              3           3
##   9                 3           3
##   9.6               5           9
##   surface          47          75
```

* What about the Reps?

```r
  table(Cyano$Rep,useNA='ifany')
```

```
## 
##    1    2    3 <NA> 
##  548  210  204 3538
```

* Should we use the filtered or unfiltered samples?

```r
  table(Cyano$Filtered,useNA='ifany')
```

```
## 
## FALSE  TRUE 
##  2717  1783
```

* Should we use the frozen or fresh samples? Probably the fresh.

```r
  table(Cyano$Frozen,useNA='ifany')
```

```
## 
## FALSE  TRUE  <NA> 
##  2035  2464     1
```





