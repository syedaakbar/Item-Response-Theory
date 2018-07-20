#setwd
library(ltm)
library(sm)
library(irtoys)

resp<- read.csv("Mount litera - 27R.csv")
ip <- read.csv("parameters2PL_27R.csv")

#ability using BMA
ab <- mlebme(resp,ip,mu = 500, sigma = 100, method = "BL")

# ability using MLE 
ab <-mlebme(resp, ip)
write.csv(ab,"ability_bme.csv")

# Z3 index - a measure of person fit
api(resp,ip)


#Normal Prior Assumed (Bayes Modal Estimation) - without using irtoys library
#setwd

para <- read.csv("parameters.csv", header = TRUE)  #Read item parameters in same order as they appear in student data
data<- read.csv("respmat_34Mcombined_test.csv", header = TRUE)    #student wise item wise correct/incorrect

datacol <- ncol(data)


for (i in 1:nrow(data))   #Loop running over each student
{
  Lik_Func <- 1      #Reset for each student
  Lik_Func_opt <- 0   #Reset for each student
  
  for (theta in seq(-3, 3, by = 0.01)) #Loop to estimate student ability
  {
    Lik_Func <- 1     #Reset for each theta
    Lik_Func <- (1/(2*pi)^0.5)*exp(-0.5*(theta)^2)  #Normal distribution prior - theta which is close to mean is more likely then one which is on the extreme
    #But since the population using which item parameters were estimated different from the population being tested here, not sure if normal curve should have mean of 0...
    #Can iterate...calculate mean and SD once using vanilla likelhood and use that as the prior and reestimate
    for(j in 2:nrow(para)+1)  #First column contains student ID
    {
      if ((data[i,j]==1) | (data[i,j]==0))  #condition to ignore blank cells
      {
        Lik_Func <- Lik_Func*(((exp(para[j-1,3]*(theta - para[j-1,2])))/(1+(exp(para[j-1,3]*(theta - para[j-1,2])))))^data[i,j])*((1/(1+(exp(para[j-1,3]*(theta - para[j-1,2])))))^(1 - data[i,j]))
      }
    }
    if (Lik_Func > Lik_Func_opt)
    { 
      data[i, datacol+1] <- theta
      Lik_Func_opt <- Lik_Func
    }   
  }
}

#write.csv(data, "data.csv")