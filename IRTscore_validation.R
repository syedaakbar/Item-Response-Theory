#IRT score validation script
#Vetical linking validation
#Can be also used to check DIF
#2PL IRT model

library(ggplot2)
library(plyr)

data = read.csv("Class 7 BME.csv")
parameters = read.csv("Class 7 maths calibrated.csv")

minability = -3
maxability = 3
binsize = 0.1
totalbins = 60
nostudents = nrow(data)
lastcol = 109

noofitems = nrow(parameters)

arrayactual = matrix(data = 0.5, nrow = totalbins, ncol = noofitems)  

arraypredicted =  matrix(data = 1, nrow = totalbins, ncol = noofitems) 


#Loop to calculate  predicted item performance
for (i in 1:totalbins)
{
  theta = -3 + 0.1*i - 0.05
for (j in 1:noofitems)
  {
  DF = parameters[j,2]
  DS = parameters[j,3]
  arraypredicted[i,j] = exp(DS*(theta-DF))/(1+exp(DS*(theta-DF)))
  }
}
#Loops for getting actual values
#Nested loops - In first loop decide student falls in which bin and then in second loop calculate the actual value for all items using second loop
for (i in 1:nostudents)
{
  theta = data[i,lastcol]
  bin = ceiling((3 + theta)/0.1)
  data[i,lastcol+1] = bin
}
colnames(data)[lastcol+1]="bin" #give name to new cloumn for subsetting later


for (i in 1:totalbins)
{
  temp = data[which(data$bin == i),]
for (j in 1:noofitems)
{
  arrayactual[i,j] = mean(temp[,j+2],na.rm=TRUE)
  
}
}

#Plotting data in grid

ability = c(c(1:totalbins),c(1:totalbins))
label = c(rep("Actual",totalbins),rep("Predicted",totalbins))


chartlist = list()
for (j in 100:108)
{
  plotdata = c(arrayactual[,j],arraypredicted[,j])
  ability_name = "Ability"
  plotdata_name <- "Scores"
  label_name <- "Label"
  plotdata1 <- data.frame(ability,plotdata,label)
  names(plotdata1) <- c(ability_name,plotdata_name,label_name)
  #Need to combine these two in dataframe
  #Plot one chart first
  validation = ggplot(plotdata1) + geom_line(aes(x=Ability, y=Scores, colour=Label)) + scale_colour_manual(values=c("red","green"))
  title = paste("Item",parameters[j,1])
  validation <- validation + xlab("Scores") + ylab("Accuracy") + ggtitle(title)
  chartlist[[j-99]] = validation
}

library(gridExtra)
do.call("grid.arrange", c(chartlist))
# y = data is for x axis or y axis
# data has to be in dataframe
# x is the variable which contains the scores, so give the corresponding column name as input
# color is the variable which captures if more than one category is there