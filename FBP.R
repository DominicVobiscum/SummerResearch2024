library(PET)
library(png)
filt1 <- read.csv("raw_data/filtsino2.csv")
filt1 <- as.matrix(filt1)
image(filt1)
filt2 <- read.csv("raw_data/filtsino3.csv")
filt2 <- as.matrix(filt2)
image(filt2)
FBP1 <- iradon(filt1, XSamples = 65, YSamples = 65, mode = "BF")
filt1data <- FBP1$irData
image(filt1data)
FBP2 <- iradon(filt2, XSamples = 65, YSamples = 65, mode = "BF")
filt2data <- FBP2$irData
image(filt2data)
b1 <- matrix(0.148085798, nrow = 65, ncol = 65)
b2 <- matrix(-1.762962640, nrow = 65, ncol = 65)
filta <- filt1data - b1
filtb <- filt2data - b2
filtsa <- matrix(nrow = 65, ncol = 65)
for (i in 1:nrow(filta)){
  for (j in 1:ncol(filta)){
    filtsa[i,j] <- -0.4682363/(1+exp(-filta[i,j]))
  }
}

image(filtsa)
filtsb <- matrix(nrow = 65, ncol = 65)
for (i in 1:nrow(filtb)){
  for (j in 1:ncol(filtb)){
    filtsb[i,j] <- 0.8518907/(1+exp(-(filtb[i,j])))
  }
}
image(filtsb)

filtsab <- filtsa + filtsb
image(filtsab)

b3 <- matrix(0.4746335, nrow = 65, ncol = 65)

filtsab2 <- filtsab - b3
filtsab2
image(filtsab2)

filtf <- matrix(nrow = 65, ncol = 65)
for (i in 1:nrow(filtsab2)){
  for (j in 1:ncol(filtsab2)){
    filtf[i,j] <- -1/(1+exp(-(filtsab2[i,j])))
  }
}

filtf2 <- matrix(nrow = 65, ncol = 65)
for (i in 1:nrow(filtsab2)){
  for (j in 1:ncol(filtsab2)){
    filtf2[i,j] <- 1/(1+exp(-(filtsab2[i,j])))
  }
}

image(filtf)
image(filtf2)
write.csv(filtf, "clean_data/FBP1.csv")
write.csv(filtf2, "clean_data/FBP2.csv")



