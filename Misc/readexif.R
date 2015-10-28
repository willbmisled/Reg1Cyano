#http://dougshartzer.blogspot.com/2014/09/collecting-camera-exif-data-through-r.html


#Note:  the switch -c %.6f in the command below control the formating of the GPS coordinates as dd.  see  http://www.sno.phy.queensu.ca/~phil/exiftool/exiftool_pod.html

Tool<-'c:/bryan/portableapps/exiftool/exiftool.exe'
Photo<-'c:/bryan/bryanTemp/a.jpg'

cmd <- paste(App ,shQuote('%.6f'), shQuote(filename))
cmd <- paste(Tool,' -c ' ,shQuote('%.6f'), shQuote(Photo))

exifdata <-  system(cmd,intern=T)




#This function calls exiftool, a command line application that returns exif data from photo files, searches the file for pertinent data, and returns those values in a 
#vector.  If nothing is found, ‘UNKNOWN’ is returned.


getexifdata <- function(Tool,Photo){
  cmd <- paste(Tool,' -c ' ,shQuote('%.6f'), shQuote(Photo)) #create the MSDOS command we’ll be using.
  exifdata <-  system(cmd,intern=T)  #use the MSDOS command using the system function.
  
  #the system command that calls exiftool returns a vector.  Each line consists of one property value of the photo.  It’s starts with the name of the property and the actual value starts at the 35th character.
  #these next few lines are searching the returned vector for specific property value using the name found at the beginning.  
  #If found, collect the property value starting at character 35.  Since there can be multiple matches, collect only the first item found.  Search different possible labels as camera companies name stuff differently.
  
  imageheight <- substring(exifdata [grep('^Exif Image Height        |Image Height  ',exifdata )[1]],35,nchar(exifdata [grep('^Exif Image Height       |Image Height  ',exifdata )[1]]))
  imagewidth <- substring(exifdata [grep('^Exif Image Width      |Image Width ',exifdata )[1]],35,nchar(exifdata [grep('^Exif Image Width      |Image Width ',exifdata )[1]]))
  gpslatitude <- substring(exifdata [grep('^GPS Latitude      ',exifdata )[1]],35,nchar(exifdata [grep('^GPS Latitude       ',exifdata )[1]]))
  gpslongitude <- substring(exifdata [grep('^GPS Longitude      ',exifdata )[1]],35,nchar(exifdata [grep('^GPS Longitude       ',exifdata )[1]]))
  cameramodel <- substring(exifdata [grep('^Camera Model Name      ',exifdata )[1]],35,nchar(exifdata [grep('^Camera Model Name       ',exifdata )[1]]))
  createdate <- substring(exifdata [grep('^Create Date      |File Creation Date',exifdata )[1]],35,nchar(exifdata [grep('^Create Date      |File Creation Date',exifdata )[1]]))
  
  #If no value is found, NA is returned. Set to ‘UNKNOWN’
  
  if (is.na(imagewidth)){imagewidth <- 'UNKNOWN'}
  if (is.na(imageheight)){imageheight <- 'UNKNOWN'}
  if (is.na(gpslatitude)){gpslatitude <- 'UNKNOWN'}
  if (is.na(gpslongitude)){gpslongitude <- 'UNKNOWN'}
  if (is.na(cameramodel)){cameramodel <- 'UNKNOWN'}
  if (is.na(createdate)){createdate <- 'UNKNOWN'}
  #return values as a vector.
  print(c(imagewidth,imageheight, gpslatitude, gpslongitude,cameramodel, createdate))
  return(exifdata)
  
}

Tool<-'c:/bryan/portableapps/exiftool/exiftool.exe'
Photo<-'c:/bryan/bryanTemp/a.jpg'
Photo<-'c:/bryan/bryanTemp/IMG_0793.JPG'
Photo<-'c:/bryan/bryanTemp/NL.JPG'
Photo<-'c:/bryan/bryanTemp/NancyLeland20150527.JPG'

a<-getexifdata(Tool, Photo)
a

Dir<-'C:/Bryan/PortableApps/R/scripts/Reg1Cyano/Data2015/Photos2015'
Photos<-paste(Dir,'/',list.files(Dir),sep='')

for(i in c(1:length(Photos))) a<-getexifdata(Tool, Photos[i]);Photos[i]

i<-1
a<-getexifdata(Tool, Photos[i]);Photos[i]


