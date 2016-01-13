####This function is specific to the 2015 cyanoMon data.  It reads the Field data from the cyanoMon data entry template.
#remove existing df 
Field<<-NA

readField2015<-function(excelFile='CRWA_2015_EPA_CyanoData.xls'){
#read Field data
  Data<-paste('rawData/',excelFile,sep='') 
  Error<-"Field Data Not Read"
  Field<-tryCatch(read.xlsx(Data,sheetName='Field Data Entry',stringsAsFactors=FALSE),error = function(e)   
      Error)
      if(!is.data.frame(Field)) stop(Error) 

#Check to make sure all variables were read
Name<-c('orgID','ContactName','Email','Phone','waterbodyID','waterbodyName','state','town','commentWB','stationID','stationDescription','stationType','longitudeSta','latitudeSta','locationSourceSta','commentStation','sampleID','sampleDate','sampleTime','fieldCrew','sampleMethod','sampleRep','sampleDepthM','waterTempC','photoSample','surfaceWaterCondition','weather','commentSample')

Error<-"Field Data have missing variables"
Field<-tryCatch(Field[,Name],error = function(e) Error)
    if(!is.data.frame(Field)) stop(Error)

#eliminate blank rows
Field<-Field[!is.na(Field$waterbodyID),]

#reformat data
#character data
for(i in c(1:12,15:17,20:22,25:28)) Field[,Name[i]]<-as.character(Field[,Name[i]])
#numeric data
for(i in c(13,14,23,24)) Field[,Name[i]]<-as.numeric(Field[,Name[i]])
#date data
Field$sampleDate<-as.Date(Field$sampleDate)
#time data (still needs work)
#Field$sampleTime<-as.POSIXct(Field$sampleTime)

return(Field)
}


