#My Plotting Script
#Basic R: ggplot2

library(ggplot2)
library(reshape2)

#Load the Data
rawdata <- read.csv("plotdata.csv", header=TRUE)

#Converts the data to simple X Y coordinates by Subject and condition
melted = melt(rawdata, id.vars="Subject", measure.vars= c("a","c","d","e","f","g","j","k"))

ggplot(rawdata, aes(x=Subject, y=a, group=Subject)) + geom_point()

#Generates a ggplot and stores it in the variable myPlot
myPlot <- ggplot(melted, aes(x=variable, y=value, col=Subject, group=Subject))+ geom_point()+geom_line()+
  xlab("X Axis")+
  ylab("Y Axis")+ 
  ggtitle("New plot")

#Displays plot in Plots panel
myPlot

#save plot to PDF
ggsave(filename="MyPlot.pdf", plot=myPlot)
