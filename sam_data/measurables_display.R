
library(mgcv)
library(ggplot2)
library(scales)
library(tidyr)
library(dplyr)
library(lubridate)


#setwd("X:/OHSU Shared/Restricted/SOM/FM/FAMMED/Reporting Dashboard/Sam/FM/R_Analysis/Projects/Other/sam_data")
setwd("F:/temp")
wkbk <- "fitbit_export_20141029.csv"
df <- read.csv(wkbk,skip=1,header=T)

df
str(df)

df
df1 <- df[c(-4,-5)]  #remove %fat and BP
#df1[df1==0] <- NA    #replace zero values with "NA" for plotting (plots will ignor NA values)
df1[df1 <= 1] <- NA  #replace 0.10 values with "NA" for plotting (plots will ignor NA values)
df1$Date <- ymd(df$Date)

df1
str(df1)

# m <- ggplot(data=df1,aes(x=Date,y=Weight)) + geom_line() + geom_point() + 
#      geom_smooth(method="lm") +
#      coord_cartesian(xlim=c(mdy("08-26-2014"),mdy("9-26-2014")),
#                   ylim=c(200,208)) 

m <- ggplot(data=df1,aes(x=Date,y=Weight))  + geom_point() +
#      geom_smooth(method="lm")
     geom_smooth(method="lm",formula=y ~poly(x,2),size=1) 
#     geom_smooth(method="gam",formula=y ~ s(x,k=3), size=1) 
#     coord_cartesian(xlim=c(mdy("08-25-2014"),mdy("10-09-2014")),
#                  ylim=c(195.5,208)) 


m

m2 <- m + ggtitle("Sam - EOD Diet") +
#   ylab("Phone Calls / Month") +
  theme(
    axis.title         = element_text(face="italic", colour="darkred", size=12),
    axis.text.y        = element_text(colour = "black", size=8),
    axis.title.x       = element_blank(),
    legend.title       = element_blank(),
    
    plot.title  = element_text(colour="darkred", size=14))

m2

