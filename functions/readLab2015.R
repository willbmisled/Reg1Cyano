####This function is specific to the 2015 cyanoMon data.  It reads the Lab data from the cyanoMon data entry template.

readLab2015<-function(excelFile='CRWA_2015_EPA_CyanoData.xls'){
#remove existing df 
  Lab<<-NA
#read Lab data
  Data<-paste('rawData/',excelFile,sep='') 
  Error<-"Lab Data Not Read"
  Lab<-tryCatch(read.xlsx(Data,sheetName='Lab Data Entry',stringsAsFactors=FALSE),error = function(e)   
      Error)
      if(!is.data.frame(Lab)) stop(Error) 

#Check to make sure all variables were read
Name<-c('waterbodyID','stationID','sampleID','sampleDate','analysisID','analysisDate','analystName','frozen','filtered','dilution','sampleTemperatureC','ChlaUGL','PhycoUGL','analysisRep','fluorometerType','photosAnalysis','commentAnalysis')

Error<-"Lab Data have missing variables"
Lab<-tryCatch(Lab[,Name],error = function(e) Error)
    if(!is.data.frame(Lab)) stop(Error)

#eliminate blank rows
Lab<-Lab[!is.na(Lab$waterbodyID),]

#reformat data
#character data
for(i in c(1:3,5,7:10,14:17)) Lab[,Name[i]]<-as.character(Lab[,Name[i]])
#numeric data
for(i in c(11:13)) Lab[,Name[i]]<-as.numeric(Lab[,Name[i]])
#date data
Lab$sampleDate<-as.Date(Lab$sampleDate)
Lab$analysisDate<-as.Date(Lab$analysisDate)

return(Lab)
}


