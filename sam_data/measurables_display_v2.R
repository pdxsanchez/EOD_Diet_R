library(mgcv)
library(ggplot2)
library(scales)
library(tidyr)
library(dplyr)
library(lubridate)

setwd("F:/temp")
wkbk <- "fitbit_export_20141122.csv"
df <- read.csv(wkbk,skip=1,header=T)
str(df)

df1 <- df[c(-4,-5)]  #remove %fat and BP
df1[df1 <= 1] <- NA  #replace values less than 0.10 w/ "NA" for plotting 
                     #(plots will ignore NA values)
df1$Date <- ymd(df$Date) #Replace factors with real dates
str(df1)

m <- ggplot(data=df1,aes(x=Date,y=Weight))  + geom_point() +
     geom_smooth(method="lm",formula=y ~poly(x,2),size=1) #2nd order polynomial 
  #  geom_smooth(method="lm",formula=y ~poly(x,5),size=1) #5th order polynomial 
m
m2 <- m + ggtitle("Sam - EOD Diet") +
  theme(
    axis.title         = element_text(face="italic", colour="darkred", size=12),
    axis.text.y        = element_text(colour = "black", size=8),
    axis.title.x       = element_blank(),
    legend.title       = element_blank(),    
    plot.title  = element_text(colour="darkred", size=14))
m2