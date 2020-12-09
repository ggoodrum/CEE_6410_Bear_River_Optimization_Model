# Course: CEE 6410
# Final Project: Bear River Barrier Removal Optimization
# Author: Greg Goodrum
# Date: 12/04/2020


# -------------------------------------------------------------------------- #
# Reach data processing
  # Clear workspace
    rm(list=ls())

  # Load packages
    if(!require("dplyr")){
      install.packages("dplyr", dependencies = T); library(dplyr)}

  # Load data
    setwd('c:/Users/A02290896/Documents/Coursework/CEE_6410_Goodrum/Project/Spatial/Projects/')
    dat <- read.csv('BR_Network_Reaches.csv', header = T)
    
  # Summarize quality-weighted available habitat for each barrier
    dat.sumL <- aggregate(Length_km ~ DS_Barrier_Name, dat, sum)
    dat.sumQWL <- aggregate(Length_km_QW ~ DS_Barrier_Name, dat, sum)
    
# -------------------------------------------------------------------------- #
    
    
# -------------------------------------------------------------------------- #
# Calculating IIC numerator value
# This comes from directions in line 46 of the 'Optimization Model' GAMS code. 
# It is unclear whether this is correct because MKs data is too vast to repeat and test.
    # Clear workspace
    rm(list=ls())
    
    # Load packages
    if(!require("readxl")){
      install.packages("readxl", dependencies = T); library(readxl)}
    
    # Enter data
    A_months <- c(410.787, 78.787, 18.73118, 24.58744, 17.432, 29.56739,
                  1348.147, 234.8359, 234.8359, 9.624103, 3019.409, 31.44734)
    
    setwd('c:/Users/A02290896/Documents/Coursework/CEE_6410_Goodrum/Project/BR_Optimization_Model/')
    in.links <- as.data.frame(read_excel('INPUT_BR.xlsx', sheet = 6))
    links <- in.links[2:11]
    
    # Calculate IIC (pure speculation)
    out <- data.frame(matrix(nrow = 10, ncol = 10))
    for(i in 1:10){
      for(j in 1:10){
        if(links[i,j] == 1){
          out[i,j] <-  0
        } else {
          out[i,j] <- (A_months[i]*A_months[j])/links[i,j]
        }
      }
    }
    
    IIC.num <- sum(out)
    
# -------------------------------------------------------------------------- #