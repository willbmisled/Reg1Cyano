###############################################################################
# R Script to build figures included in Lake Lines article
# J.W. Hollister
# March 2015
###############################################################################

library(ggplot2)
library(dplyr)

dat<-read.csv("Data2014/Data2014.csv")

dat %>%
  select(State,Parameter,Value)%>%
  filter(Parameter=="Chlorophyll")%>%
  na.omit()%>%
  group_by(State)%>%
  summarize(chla_mn = mean(Value))%>%
  ggplot(aes(x=State,y=chla_mn)) +
    geom_bar(stat="identity")

dat %>%
  select(State,Parameter,Value)%>%
  filter(Parameter=="Phycocyanin")%>%
  na.omit()%>%
  group_by(State)%>%
  summarize(phyco_mn = mean(Value))%>%
  ggplot(aes(x=State,y=phyco_mn)) +
  geom_bar(stat="identity")
