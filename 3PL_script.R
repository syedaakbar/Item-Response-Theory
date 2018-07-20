setwd("C:\\Syeda\\Documents")
library(ltm)

respmat_3L <- read.csv("17V_dataAdditional.csv")

#When response data is in mulitple files 
#lisForms_3L <- list(LANG_3A, LANG_3B, LANG_3C)
#respmat_3L <- testEquatingData(lisForms_3L)
#write.csv(respmat_3L, "respmat_3L.csv")

#fitting two parameter model to data
fit2PL_3L <- ltm(respmat_3L ~ z1,IRT.param=TRUE)

#fitting a 3-parameter model to data
fit2PL_3L <- tpm(respmat_3L)
fit2PL_3L <- ttm(respmat_3L,start.val="random")
fit2PL_3L <- tpm(respmat_3L,control=list(optimizer="nlminb"))
fit2PL_3L <- rasch(respmat_3L, IRT.param=TRUE)

scaledscore2PL_3L <- factor.scores(fit2PL_3L)

write.csv(scaledscore2PL_3L[1], "scaledscore2PL_3L.csv")
write.csv(coef(fit2PL_3L), "parameters_.csv")

#Summary statistics
i2PL_3L <- item.fit(fit2PL_3L)
AIC2PL_3L <- summary(fit2PL_3L)$AIC

#plot of IICs and ICCs 
plot2PL_3L <- plot(fit2PL_3L,type="ICC",items=c(19,33), zrange=c(-5,5),legend=TRUE)
plot2PL_3L <- plot(fit2PL_3L,type="IIC",items=c(19,33),zrange=c(-4,4),legend=TRUE)

#test information - relaibility measures
information(fit2PL_3L,items =1, c(-3,3))
vals <- plot(fit2PL_3L, type = "IIC", items = 0, plot = FALSE)
plot(vals[, "z"], 1 / sqrt(vals[, "info"]), type = "l", lwd = 2,
     xlab = "Ability", ylab = "Standard Error",
     main = "Standard Error of Measurement")
