
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
  gg<-ggplot()
  gg<-gg + geom_map(data=NE, map=NE,
                    aes(x=long, y=lat, map_id=region, group=group),fill="#ffffff",color="#7f7f7f", size=.5) #map of states
  gg<-gg + geom_point(data=Cyano,
                      aes(x=Centroid_Long, y=Centroid_Lat,size=5),
                      color="#299868")                              #add lake points
  gg<-gg + coord_map("albers", lat0=39, lat1=45)                    #reproject to albers
  gg<-gg + theme(
    #panel.background = element_blank(),                             #remove background
    panel.background = element_rect(fill = NA,
                                    colour = "black",
                                    size = 1, linetype = "solid"),
    panel.grid.major = element_line(size = 0.5, linetype = 'solid', #major grid color
                                    colour = "darkgrey"),           
    panel.grid.minor = element_blank(),                             #remove minor grid
    legend.position="none")                                         #no legend

  gg<-gg + xlab("")     #x label
  gg<-gg + ylab("")     #y label
  gg<-gg + theme(axis.title= element_text(face="bold", size=20))  #format x label
  gg<-gg + theme(axis.text=element_text(angle=0, vjust=0.5, size=16)) #format y label
  #gg<-gg +ggtitle("mapNewEnglandCyanoIncidents.R")                   #add title?
  gg<-gg + annotate("text", x = -69, y = 46, label = "ME")            #add State annottations
  gg<-gg + annotate("text", x = -71.5, y = 44.2, label = "NH")
  gg<-gg + annotate("text", x = -72.8, y = 44.2, label = "VT")
  gg<-gg + annotate("text", x = -72.6, y = 42.4, label = "MA")
  gg<-gg + annotate("text", x = -72.7, y = 41.6, label = "CT")
  gg<-gg + annotate("text", x = -71.4, y = 41.3, label = "RI")
  gg
  
  ggsave("Analysis/mapClosures.tiff",gg,dpi=300)
  
  









windows(7,7)
  gg<-ggplot()
  gg<-gg + geom_map(data=NE, map=NE,
                       aes(x=long, y=lat, map_id=region, group=group),fill="#ffffff",color="#7f7f7f", size=.5) 
  gg<-gg + geom_point(data=Cyano,
                         aes(x=Centroid_Long, y=Centroid_Lat,size=5),
                         color="#299868")
  gg<-gg + coord_map("albers", lat0=39, lat1=45)
  #gg<-gg + theme_bw()  #remove background color and change gridlines to grey
  #gg<-gg + theme(legend.position="none") #no legend
  gg<-gg + xlab("Longitude")
  gg<-gg + ylab("Latitude")
  gg<-gg + theme(axis.title= element_text(face="bold", size=20))
  gg<-gg + theme(axis.text=element_text(angle=0, vjust=0.5, size=16))
  gg<-gg +ggtitle("mapNewEnglandCyanoIncidents.R")
  gg<-gg + annotate("text", x = -69, y = 46, label = "ME")
  gg<-gg + annotate("text", x = -71.5, y = 44.2, label = "NH")
  gg<-gg + annotate("text", x = -72.8, y = 44.2, label = "VT")
  gg<-gg + annotate("text", x = -72.6, y = 42.4, label = "MA")
  gg<-gg + annotate("text", x = -72.7, y = 41.6, label = "CT")
  gg<-gg + annotate("text", x = -71.4, y = 41.2, label = "RI")
  gg

ggsave("Analysis/mapClosures.tiff",gg,dpi=300)




gg<-ggplot()
gg<-gg + geom_map(data=NE, map=NE,
                  aes(x=long, y=lat, map_id=region, group=group),fill="#ffffff",color="#7f7f7f", size=.5) 
gg<-gg + theme(
  panel.background = element_blank(),
  panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                  colour = "red"), 
  panel.grid.minor = element_blank(),
  legend.position="none"
)
gg



myplot + theme(panel.background = element_blank())

panel.background = element_rect(fill = "lightblue",
                                colour = "lightblue",
                                size = 0.5, linetype = "solid"),


panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                colour = "green")