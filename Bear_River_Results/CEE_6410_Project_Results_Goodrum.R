# Course: CEE 6410
# Final project results plotting
# Author: Greg Goodrum
# Last Update: 12/8/2020


# -------------------------------------------------------------------------- #
# Data and workspace setup
  # Clear workspace
    rm(list=ls())

  # Load packages
    # if(!require("NADA")){
    #   install.packages("NADA", dependencies = T); library(NADA)}
    
  # Load data
    setwd('c:/Users/A02290896/Documents/Coursework/CEE_6410_Goodrum/Project/Results/Output_data/')
    barr.rmv <- read.csv('barriers_removed.csv', header = T)
    ecoLoss <- read.csv('economicloss.csv', header = T)
    qualLen <- read.csv('quality_length.csv', header = T)
    spent <- read.csv('spent.csv', header = T)
  
  # Add budgets to output tables
    scensNums <- seq(1,22,1)
    for(i in 1:length(scensNums)){
      scensNums[i] <- paste0('S', as.character(scensNums[i]))
    }
    
    budgets <- c(50000, 100000, 200000, 300000, 500000, 750000, 1000000, 1500000, 5000000,
                 10000000, 20000000, 30000000, 50000000, 70000000, 80000000, 90000000,
                 100000000, 150000000, 200000000, 250000000, 300000000, 350000000)
    
    budScens <- setNames(as.data.frame(cbind(scensNums, budgets)),
                         c('Scenario', 'Budget'))
    budScens$budMils <- as.numeric(budScens$Budget)/1000000
    
    addBudget <- function(inTable, inBudget){
      Budget <- rep(NA, nrow(inTable))
      out <- as.data.frame(cbind(inTable, Budget))
      for(i in 1:nrow(inTable)){
        out$Budget[i] <- inBudget$budMils[which(inBudget$Scenario == out$Scenario[i])]
      }
      return(out)
    }
    
    barr.rmv <- addBudget(barr.rmv, budScens)
    ecoLoss <- addBudget(ecoLoss, budScens)
    qualLen <- addBudget(qualLen, budScens)
    spent <- addBudget(spent, budScens)
    
  # Add barrier names to barrier table
    
    barrNums <- seq(550, 560, 1)
    
    barrNames <- c('GSL', 'Daniels', 'Devil Creek', 'Deep Creek', 'Weston', 'Five Mile',
                   'Cutler', 'Oneida', 'Grace', 'Soda Springs', 'Montpelier')
    
    barriers <- setNames(as.data.frame(cbind(barrNums, barrNames)),
                         c('BarrID', 'Name'))
    
    addBarrier <- function(inTable, inBarriers){
      Barrier_Name <- rep(NA, nrow(inTable))
      out <- as.data.frame(cbind(inTable, Barrier_Name))
      for(i in 1:nrow(inTable)){
        out$Barrier_Name[i] <- inBarriers$Name[which(inBarriers$BarrID == out$Barrier[i])]
      }
      return(out)
    }
    
    barr.rmv <- addBarrier(barr.rmv, barriers)
    
  # Convert scarcity to millions
    ecoLoss$WscarMils <- as.numeric(ecoLoss$Wscarc_cost / 1000000)
    
# -------------------------------------------------------------------------- #
  

    
# -------------------------------------------------------------------------- #
# Plot barriers removed
  windows()
  par(mar=c(5,10,1,1))
  
  # Plot Barriers
  plot(Barrier ~ Budget, data = barr.rmv, pch = 15, xlim = c(0,400), ylim = c(549, 561), cex = 1.25,
       xlab = 'Budget (Millions $)', ylab = '', axes = F)
  axis(2, at = 550:560, labels = unique(barriers$Name), las = 2)
  axis(1, at = c(0, 100, 200, 300, 400), labels = c(0, 100, 200, 300, 400))
  
  # Plot Reconnected habitat ~ Budget
  par()
  plot(QL_Recon ~ Budget, data = qualLen, pch = 19, xlim = c(0,400), ylim = c(0, 800), cex = 1.25,
       xlab = 'Budget (Millions $)', ylab = 'Reconnected habitat (km)')
  
  # Plot habitat vs budget
  plot(QL_Recon ~ Budget, data = qualLen, pch = 19, xlim = c(0,400), ylim = c(0, 800), cex = 1.25,
       xlab = 'Budget (Millions $)', ylab = 'Reconnected habitat (km)')
  
  #Plot scarcity vs budget
  plot(WscarMils ~ Budget, data = ecoLoss, pch = 19, xlim = c(0,400), ylim = c(0, 10), cex = 1.25,
       xlab = 'Budget (Millions $)', ylab = 'Water scarcity cost (Millions $)')
  
  # Plot habitat vs scarcity
  qualLen$Scarcity <- NA
  for(i in 1:nrow(qualLen)){
    qualLen$Scarcity[i] <- 0
  }
  for(i in 7:nrow(qualLen)){
    qualLen$Scarcity[i] <- ecoLoss$WscarMils[which(ecoLoss$Scenario == qualLen$Scenario[i])]
  }
  plot(Scarcity ~ QL_Recon, data = qualLen, pch = 19, xlim = c(0,800), ylim = c(0, 10), cex = 1.25,
       xlab = 'Reconnected habitat (km)', ylab = 'Water scarcity cost (Millions $)')
  
  
