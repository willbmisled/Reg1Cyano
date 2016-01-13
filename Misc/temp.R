



library(xlsx)

readData<-function(excelFile='CRWA_2015_EPA_CyanoData.xls'){
  #create space to hold messages and flags
    flag<-0
    flags<-NA
    Abort<-0  
  
#read field data
  Data<-paste('Data2015/rawData/',excelFile,sep='') 
  Error<-"Field Data Not Read"
  Field<-tryCatch(read.xlsx(Data,sheetName='Field Data Entry',stringsAsFactors=FALSE),error = function(e)   
      Error)
      if(!is.data.frame(Field)){        
        flag<-flag+1
        flags[flag]<-Error
        Abort<-1} 
  if(Abort==1) stop(Error)

#Check to make sure all variables were read
Name<-c('orgID','ContactName','Email','Phone','waterbodyID','waterbodyName','state','town','commentWB','stationID','stationDescription','stationType','longitudeSta','latitudeSta','locationSourceSta','commentStation','sampleID','sampleDate','sampleTime','fieldCrew','sampleMethod','sampleRep','sampleDepthM','waterTempC','photoSample','surfaceWaterCondition','weather','commentSample')

Error<-"Field Data have missing variables"
Field<-tryCatch(Field[,Name],error = function(e) Error)
    if(!is.data.frame(Field)){        
      flag<-flag+1
      flags[flag]<-Error
      Abort<-1} 
    if(Abort==1) stop(Error)



return(Field)
}

readData()



#field names flag
a<-as.data.frame(table(fieldName%in%c('orgID','ContactName','Email','Phone','waterbodyID','waterbodyName','state','town','commentWB','stationID','stationDescription','stationType','longitudeSta','latitudeSta','locationSourceSta','commentStation','sampleID','sampleDate','sampleTime','fieldCrew','sampleMethod','sampleRep','sampleDepthM','waterTempC','photoSample','surfaceWaterCondition','weather','commentSample')))

if((a$Freq[a$Var1==TRUE]==28)==FALSE){
  print("Check  Field Data Variable Names")
}else{
}

#check to make sure all fields were read and formatted correctly
Name<-c('orgID','ContactName','Email','Phone','waterbodyID','waterbodyName','state','town','commentWB','stationID','stationDescription','stationType','locationSourceSta','commentStation','sampleID','fieldCrew','sampleMethod','sampleRep','photoSample','surfaceWaterCondition','weather','commentSample')


for(i in c(1:length(Name))) {
  a<-NA
  a<-tryCatch(as.character(Field[,Name[i]]),error = function(e) NA)
    if(is.character(a)) {
      Field[,Name[i]]<-a
    }else{
      flag<-flag+1;flags[flag]<-paste("Field$",Name[i]," missing",sep='')}
}  
    
'longitudeSta','latitudeSta', 'sampleDate','sampleTime' 'sampleDepthM','waterTempC',


inClass<-as.data.frame(unlist(lapply(Field,class)))
    
    
    

  
  
a<-'Field$orgID';tryCatch(assign(a)<-as.character(get(a)) ,error = function(e) "") 


a<-'orgID' 
  
Name<-c('orgID','ContactName','Email','Phone','waterbodyID','waterbodyName','state','town','commentWB','stationID','stationDescription','stationType','longitudeSta','latitudeSta','locationSourceSta','commentStation','sampleID','sampleDate','sampleTime','fieldCrew','sampleMethod','sampleRep','sampleDepthM','waterTempC','photoSample','surfaceWaterCondition','weather','commentSample')  
  
  
  
  
  Lab<-tryCatch(read.xlsx2(Data,sheetName='Lab Data Entry',stringsAsFactors=FALSE),error = function(e)   
    "Lab Data Not Read")
      if(!is.data.frame(Lab)) flag<-flag+1;flags[flag]<-Lab
  
  
  tryCatch(Field<-read.xlsx(Data,sheetName='Field Data Entry1',stringsAsFactors=FALSE),error = function(e) "Field Data Not Read")
  
  flag<-0
  flags<-c()
  tryCatch(Field<-read.xlsx2(Data,sheetName='Field Data Entry1',stringsAsFactors=FALSE),
           error = function(e){
             flag<-flag+1
             flags[flag]<-"Field Data Not Read"
             return(flags[flag])})
  

  

  
#field names flag
  a<-as.data.frame(table(fieldName%in%c('orgID','ContactName','Email','Phone','waterbodyID','waterbodyName','state','town','commentWB','stationID','stationDescription','stationType','longitudeSta','latitudeSta','locationSourceSta','commentStation','sampleID','sampleDate','sampleTime','fieldCrew','sampleMethod','sampleRep','sampleDepthM','waterTempC','photoSample','surfaceWaterCondition','weather','commentSample')))
  
  if((a$Freq[a$Var1==TRUE]==28)==FALSE){
    print("Check  Field Data Variable Names")
  }else{
}

readData()
  



#################







#field names flag
a<-as.data.frame(table(fieldName%in%c('orgID','ContactName','Email','Phone','waterbodyID','waterbodyName','state','town','commentWB','stationID','stationDescription','stationType','longitudeSta','latitudeSta','locationSourceSta','commentStation','sampleID','sampleDate','sampleTime','fieldCrew','sampleMethod','sampleRep','sampleDepthM','waterTempC','photoSample','surfaceWaterCondition','weather','commentSample')))

if((a$Freq[a$Var1==TRUE]==28)==FALSE){
    print("Check  Field Data Variable Names")
}else{

#eliminate additional columns
Field<-Field[,fieldName]

#eliminate additional rows
Field<-Field[!is.na(Field$waterbodyID),]

#redefine the class of each field to make sure they match 
#if there are any character data in a numeric field the observation will be set to NA
Field$orgID<-as.character(Field$orgID)
Field$ContactName<-as.character(Field$ContactName)
Field$Email<-as.character(Field$Email)
Field$Phone<-as.character(Field$Phone)
Field$waterbodyID<-as.character(Field$waterbodyID)
Field$waterbodyName<-as.character(Field$waterbodyName)
Field$state<-as.character(Field$state)
Field$town<-as.character(Field$town)
Field$commentWB<-as.character(Field$commentWB)
Field$stationID<-as.character(Field$stationID)
Field$stationDescription<-as.character(Field$stationDescription)
Field$stationType<-as.character(Field$stationType)
Field$longitudeSta<-as.numeric(Field$longitudeSta)
Field$latitudeSta<-as.numeric(Field$latitudeSta)
Field$locationSourceSta<-as.character(Field$locationSourceSta)
Field$commentStation<-as.character(Field$commentStation)
Field$sampleID<-as.character(Field$sampleID)
Field$sampleDate<-as.Date(Field$sampleDate)
Field$sampleTime<-as.character(Field$sampleTime)  #time is problematic for now keep as character
Field$fieldCrew<-as.character(Field$fieldCrew)
Field$sampleMethod<-as.character(Field$sampleMethod)
Field$sampleRep<-as.character(Field$sampleRep)
Field$sampleDepthM<-as.numeric(Field$sampleDepthM)
Field$waterTempC<-as.numeric(Field$waterTempC)
Field$photoSample<-as.character(Field$photoSample)
Field$surfaceWaterCondition<-as.character(Field$surfaceWaterCondition)
Field$weather<-as.character(Field$weather)
Field$commentSample<-as.character(Field$commentSample)

#read lab data
Lab<-read.xlsx(Data,sheetName='Lab Data Entry',stringsAsFactors=FALSE)

#check dim; ncol should be 17
dim(Lab)

#lab names flag (should be TRUE==17)
table(labName%in%c('waterbodyID','stationID','sampleID','sampleDate','analysisID','analysisDate','analystName','frozen','filtered','dilution','sampleTemperatureC','ChlaUGL','PhycoUGL','analysisRep','fluorometerType','photosAnalysis','commentAnalysis'))

#Sometimes there are additional columns in the data-proactively eliminate these
Lab<-Lab[,labName]

#see if there are any blank lines
table(is.na(Lab$waterbodyID))

#proactively eliminate blank lines
Lab<-Lab[!is.na(Lab$waterbodyID),]
dim(Lab)

#make sure all of the variables are assigned to the correct class
Lab$waterbodyID<-as.character(Lab$waterbodyID)
Lab$stationID<-as.character(Lab$stationID)
Lab$sampleID<-as.character(Lab$sampleID)
Lab$sampleDate<-as.Date(Lab$sampleDate)
Lab$analysisID<-as.numeric(Lab$analysisID)
Lab$analysisDate<-as.Date(Lab$analysisDate)
Lab$analystName<-as.character(Lab$analystName)
Lab$frozen<-as.character(Lab$frozen)
Lab$filtered<-as.character(Lab$filtered)
Lab$dilution<-as.character(Lab$dilution)
Lab$sampleTemperatureC<-as.numeric(Lab$sampleTemperatureC)
Lab$ChlaUGL<-as.numeric(Lab$ChlaUGL)
Lab$PhycoUGL<-as.numeric(Lab$PhycoUGL)
Lab$analysisRep<-as.character(Lab$analysisRep)
Lab$fluorometerType<-as.character(Lab$fluorometerType)
Lab$photosAnalysis<-as.character(Lab$photosAnalysis)
Lab$commentAnalysis<-as.character(Lab$commentAnalysis)


}#field names flag





#check that variable classes are correctly imported:NOTE sampleTime registered twice but it's okay.
inClass<-as.data.frame(unlist(lapply(Field,class)))
test<-as.vector(inClass==fieldClass)
data.frame(inClass=inClass,template=fieldClass,test)









#check that variable classes are correctly imported
inClass<-as.data.frame(unlist(lapply(Lab,class)))
test<-as.vector(inClass==labClass)
data.frame(inClass=inClass,template=labClass,test)




#variable names and classes for field data

fieldClass<-c("character","character","character","character","character","character","character","character","logical","character","character","character","numeric","numeric","character","logical","character","Date","POSIXct","POSIXt","character","character","character","numeric","numeric","character","character","character","character")

fieldName<-c('orgID','ContactName','Email','Phone','waterbodyID','waterbodyName','state','town','commentWB','stationID','stationDescription','stationType','longitudeSta','latitudeSta','locationSourceSta','commentStation','sampleID','sampleDate','sampleTime','fieldCrew','sampleMethod','sampleRep','sampleDepthM','waterTempC','photoSample','surfaceWaterCondition','weather','commentSample')

labClass<-c('character','character','character','Date','numeric','Date','character','character','character','character','numeric','numeric','numeric','character','character','character','character')

labName<-c('waterbodyID','stationID','sampleID','sampleDate','analysisID','analysisDate','analystName','frozen','filtered','dilution','sampleTemperatureC','ChlaUGL','PhycoUGL','analysisRep','fluorometerType','photosAnalysis','commentAnalysis')

















datasets <- system.file("extdata/datasets.xlsx", package = "readxl")
read_excel(datasets)

read_excel(datasets,col_names=c(letters[1:5]),col_types=rep("text",5),skip=1)

read_excel(datasets,col_types=rep("text",5))


a<-read_excel("c:/Bryan/bryanTemp/temp.xlsx",sheet="sht1",skip=1,col_names=c('x','y','q'),col_types=c('numeric','text','text'))

a<-read_excel("c:/Bryan/bryanTemp/temp.xlsx",sheet="sht1",skip=0,col_names=TRUE,col_types=c('numeric','text','text'))

Field<-read_excel('Data2015/rawData/cyanoMon2015DataEntry- CT DEEP.xls',sheet='Field Data Entry',col_names=TRUE,col_types="text")




a<-data.frame(a=c(1:3),b=rnorm(3),c=letters[10:12])

#install packages
libs<-c("readxl","dplyr") #list of packages to load

installLoad<-function(pck){ #user defined function
  if(!pck%in%installed.packages()){install.packages(pck)}
  require(pck, character.only = TRUE)
}
lapply(libs,function(x) installLoad(x))  #Load/Install require packages
#

fieldNames<-


fieldTypes<-c('character','character','character','character','character','character','character','character','character','character','character','character','numeric','numeric','character','character','character','character','character','character','character','character','numeric','numeric','character','character','character','character')


Field<-read_excel('Data2015/rawData/cyanoMon2015DataEntry- CT DEEP.xls',sheet='Field Data Entry')

Field<-read_excel('Data2015/rawData/cyanoMon2015DataEntry- CT DEEP.xls',sheet='Field Data Entry',col_names=fieldNames,col_types=fieldTypes)

names(Field)==fieldNames
all.equal(names(Field),fieldNames)


read_excel("c:/Bryan/bryanTemp/temp.xlsx")
read_excel("c:/Bryan/bryanTemp/temp.xlsx",sheet="sht1")
read_excel("c:/Bryan/bryanTemp/temp.xlsx",sheet="sht1",skip=1,col_names=FALSE)

read_excel("c:/Bryan/bryanTemp/temp.xlsx",sheet="sht1",skip=1,col_names=c('x','y','z'))

a<-read_excel("c:/Bryan/bryanTemp/temp.xlsx",sheet="sht1",skip=1,col_names=c('x','y','q'),col_types=c('numeric','text','text'))







# Specific sheet either by position or by name
read_excel(datasets, 2)
read_excel(datasets, "mtcars",col_names=c(letters[1:10]),col)types=rep("numeric",10),skip=1)




a<-read_excel("c:/Bryan/bryanTemp/temp.xlsx",sheet='sht1',
              col_types=c('numeric','numeric','text'),
              col_names=c('x','y','z'),skip=1)



library(xlsx)

#get variable names and classes from template

tF<-read.xlsx('misc/cyanoMon2015DataEntry.xls',sheetName='Field Data Entry',stringsAsFactors=FALSE)
as.data.frame(unlist(lapply(tF,class)))


Field<-read.xlsx('Data2015/rawData/cyanoMon2015DataEntry- CT DEEP.xls',sheetName='Field Data Entry',stringsAsFactors=FALSE)

Field<-read.xlsx('Data2015/rawData/cyanoMon2015DataEntrynewestjb.xlsx',sheetName='Field Data Entry',stringsAsFactors=FALSE)


Field<-read_excel('Data2015/rawData/cyanoMon2015DataEntrynewestjb.xlsx',sheet='Field Data Entry') #15
                 
                 
                 ,sheet='Field Data Entry',col_names=TRUE,col_types="text")

as.data.frame(apply(Field,2,class))

tF<-as.data.frame(unlist(lapply(Field,class)))

a<-data.frame(labName,labClass)
