###############################################################################
# R Script to build figures included in Lake Lines article
# J.W. Hollister
# March 2015
###############################################################################

library(ggplot2)
library(dplyr)
library(wesanderson)

dat <- read.csv("Data2014/Data2014.csv")
calib <- read.csv("lakeline_figs//calibration_ct_me.csv")
names(calib)[2]<-"Value"

####################################################################################
# CT calib models
####################################################################################
dat %>% filter(State == "CT") %>% select(Parameter, Value, Units)

ct_phyco_lm <- calib %>% filter(Parameter == "Phyco" & Organization == "CTDEP") %>% 
  select(Value, Concentration) %>%
  lm(Concentration ~ Value, data = .)

ct_chloro_lm <- calib %>% filter(Parameter == "Chloro" & Organization == "CTDEP") %>% 
  select(Value, Concentration) %>%
  lm(Concentration ~ Value, data = .)

ct_chloro_conc<-dat %>% filter(State == "CT" & Parameter == "Chlorophyll") %>% select(Value) %>%
  predict(ct_chloro_lm,newdata = .)

ct_phyco_conc<-dat %>% filter(State == "CT" & Parameter == "Phycocyanin") %>% select(Value) %>%
  predict(ct_phyco_lm,newdata = .)

pred_phyco_rows<-dat %>% filter(State == "CT" & Parameter == "Phycocyanin") %>% 
  mutate(Value = ct_phyco_conc) %>% 
  mutate(Units = "ug/l") %>%
  mutate(Comments = "Predicted Concentration from calibration done at Chelmsford on June 11, 2014") %>%

pred_chloro_rows<-dat %>% filter(State == "CT" & Parameter == "Chlorophyll") %>% 
  mutate(Value = ct_chloro_conc) %>% 
  mutate(Units = "ug/l") %>%
  mutate(Comments = "Predicted Concentration from calibration done at Chelmsford on June 11, 2014")
  
dat2<-rbind(dat,pred_phyco_rows,pred_chloro_rows)
####################################################################################
# Clean up data
####################################################################################

dat_clean <- dat %>%
  filter(SampleLocation != "Other" || 
           SampleLocation != "Calibration" ||
           SampleLocation != "Blank") %>%
  filter(!Flag) %>%
  filter(Fluorometer == "Beagle")%>%
  filter(Units=="ug/l")%>%
  filter(!is.na(Longitude))%>%
  filter(!is.na(Latitude))


my_boot<-function(x,R,type=c("median","mean"),...){
  b_md<-vector("numeric",R)
  type<-match.arg(type)
  for(i in 1:R){
    b<-sample(x,length(x),replace=T)
    if(type=="median"){
      b_md[i]<-median(b,...)
    } else if (type == "mean"){
      b_md[i]<-mean(b,...)
    } else {
      stop("type must be median or mean")
    }
  }
  return(c(quantile(b_md,c(0.025,0.975)),median(b_md)))
}

dat_bar <- dat_clean %>%
  select(State,Parameter,Value,Units)%>%
  na.omit()%>%
  group_by(State,Parameter)%>%
  summarize(value_mdn = median(Value),
            value_mn = mean(Value),
            value_mdn_boot = my_boot(Value,1000,"median")[3],
            value_mn_boot = my_boot(Value,1000,"mean")[3],
            value_se = sd(Value)/sqrt(n()),
            value_iqr = IQR(Value),
            value_mdn_bootLL = my_boot(Value,1000,"median")[1],
            value_mdn_bootUL = my_boot(Value,1000,"median")[2],
            value_mn_bootLL = my_boot(Value,1000,"mean")[1],
            value_mn_bootUL = my_boot(Value,1000,"mean")[2]
            )

limits_mdn_boot<-aes(ymax=value_mdn_bootUL,ymin=value_mdn_bootLL)
dodge<-position_dodge(width=0.9)

state_bar_mdn_boot <- dat_bar %>% 
  ggplot(aes(x=State,y=value_mdn_boot,fill=Parameter)) +
  geom_bar(position="dodge",stat="identity") +
  geom_errorbar(limits_mdn_boot, position=dodge, width=0.25) + 
  theme_classic(12,"times") +
  theme(axis.title.y = element_text(vjust=1.25)) + 
  scale_fill_manual(values=wes_palettes$Moonrise2[c(2,3)]) + 
  ylab("Median Bootstrapped Value (ug/l)") + 
  theme(axis.title.y = element_text(vjust=1.25))

state_bar_mdn_boot

ggsave("lakeline_figs/state_summ_bar.tiff", state_bar_mdn_boot,dpi=150,height=4,width=6)
ggsave("lakeline_figs/state_summ_bar.jpg", state_bar_mdn_boot,dpi=300,height=4,width=6)


#dat_clean %>%
#  select(State,Parameter,Value,Units)%>%
#  filter(Parameter=="Phycocyanin")%>%
#  na.omit()%>%
#  group_by(State)%>%
#  summarize(phyco_mn = mean(Value))%>%
#  ggplot(aes(x=State,y=phyco_mn)) +
#  geom_bar(stat="identity")

#limits_mn_se<-aes(ymax=value_mn+value_se, ymin=value_mn-value_se)
#limits_mdn_iqr<-aes(ymax=value_mdn+value_iqr, ymin=value_mdn-value_iqr)

#state_bar_mn_se <- dat_bar %>% 
#  ggplot(aes(x=State,y=value_mn,fill=Parameter)) +
#  geom_bar(position="dodge",stat="identity") +
#  geom_errorbar(limits_mn_se, position=dodge, width=0.25)
#state_bar_mn_se

#state_bar_mdn_iqr <- dat_bar %>% 
#  ggplot(aes(x=State,y=value_mdn,fill=Parameter)) +
#  geom_bar(position="dodge",stat="identity") +
#  geom_errorbar(limits_mdn_iqr, position=dodge, width=0.25)
#state_bar_mdn_iqr

  