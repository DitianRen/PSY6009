#### CFA & SEM  Models####

## Input::::::df_cleand.csv 
## Libraries::tidyverse,lavaan
## Output:::::table3_CFA.csv, table3_SEM.csv, table3_CFA_fit.csv, table3_SEM_fit.csv


#Confirmatory Factor Analysis
model1 <- '
  AMM =~ MDT.ability + generalSophistication + BAT.ability
'
fit1<-cfa(model1, data = df_cleaned, missing = "FIML")
fitMeasures1 = lavaan::fitMeasures(fit1, c('chisq','df','pvalue','srmr','cfi','rmsea'))

#Structure Equaltion Modeling
model2 <- '
  AMM =~ generalSophistication + MDT.ability + BAT.ability
  WMC3 ~ AMM
  WMC6 ~ AMM
'
fit2<-sem(model2, data = df_cleaned, missing = "FIML")
fitMeasures2 = lavaan::fitMeasures(fit2, c('chisq','df','pvalue','srmr','cfi','rmsea'))

#Extract parameters of model
fit1 = parameterEstimates(fit1, standardized = TRUE)
fit2 = parameterEstimates(fit2, standardized = TRUE)

#save the result of parameters & model fits (Replace outfolder with a local path)
write.csv(fit1, file = "outfolder/table3_CFA.csv", row.names = FALSE)
write.csv(fit2, file = "outfolder/table3_SEM.csv", row.names = FALSE)
write.csv(fitMeasures1, file = "outfolder/table3_CFA_fit.csv", row.names = FALSE)
write.csv(fitMeasures2, file = "outfolder/table3_SEM_fit.csv", row.names = FALSE)


####### Clean Up #######
remove(model1)
remove(model2)
remove(fit1)
remove(fit2)
remove(fitMeasures1)
remove(fitMeasures2)