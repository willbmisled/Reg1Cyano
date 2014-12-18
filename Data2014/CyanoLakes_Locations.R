library(sp)  #load sp package
library(rgdal) #load rgdal package
library(RODBC)
setwd('data')


#read lake locations from csv
  x<-read.csv('Region1_CyanoMonitoring_Locations.csv')
  head(x)

#convert locations to a spatial points dataframe
  coords<-x[,c('Longitude','Latitude')]
  lakes<-SpatialPointsDataFrame(coords, x)  #convert to spdf
  proj4string(lakes)<-CRS("+proj=longlat +datum=WGS84")

#write shapefile
  Name<-'Region1_CyanoLakes'
  writeOGR(lakes,getwd(),Name,"ESRI Shapefile")   #create shapefile

#write kml
  writeOGR(lakes["Order"], paste(Name,'.kml',sep=''), x$Order, "KML")#create kml file

#open kml in google earth
  shell.exec(paste(getwd(),'/',Name,'.kml',sep=''))
