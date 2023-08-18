#### Pearson correlation ####

## Input::::::df_cleand.csv 
## Libraries::tidyverse, Hmisc
## Output:::::table2_correlation_r.csv, table2_correlation_p.csv


#Select the data column and calculate the correlation
table2 = df_cleaned %>%
  select(MDT.ability,BAT.ability,generalSophistication, WMC3, WMC6)
correlations = rcorr(as.matrix(table2))

#save the result in data.frame
correlations.r = data.frame(correlations$r)
correlations.r = cbind(variables = rownames(correlations.r), correlations.r)

correlations.p = data.frame(correlations$P)
correlations.p = cbind(variables = rownames(correlations.p), correlations.p)


#save the final correlation result (Replace outfolder with a local path)
write.csv(correlations.r, file = "outfolder/table2_correlation_r.csv", row.names = FALSE)
write.csv(correlations.p, file = "outfolder/table2_correlation_p.csv", row.names = FALSE)


####### Clean Up #######
remove(table2)
remove(correlations)
remove(correlations.r)
remove(correlations.p)