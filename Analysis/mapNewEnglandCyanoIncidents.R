
#locations of Lake Cyano Incidents 2009-2012; includes reports, warnings, and closures.

library(ggplot2)
library(maps)

#get closure data
  Cyano<- read.csv("Data2014/NewEnglandClosures20130618.csv")

#get map of US
  us <- map_data("state")
  us <- fortify(us, region="region")

#map of NE
  NE<-us[us$region%in%c("connecticut","maine","massachusetts","new hampshire","rhode island","vermont"),]
         
#plot

windows(7,7)
  gg<-ggplot()
  gg<-gg + geom_map(data=NE, map=NE,
                       aes(x=long, y=lat, map_id=region, group=group),
                       fill="#ffffff", color="#7f7f7f", size=1)
  gg<-gg + geom_point(data=Cyano,
                         aes(x=Centroid_Long, y=Centroid_Lat,size=5),
                         color="#299868")
  gg<-gg + coord_map("albers", lat0=39, lat1=45)
  gg<-gg + theme(legend.position="none")
  gg<-gg + xlab("Longitude")
  gg<-gg + ylab("Latitude")
  gg<-gg + theme(axis.title= element_text(face="bold", size=20))
  gg<-gg + theme(axis.text=element_text(angle=0, vjust=0.5, size=16))
  gg<-gg +ggtitle("mapNewEnglandCyanoIncidents.R")
  gg


