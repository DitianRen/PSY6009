#### Descriptive Statistic ####

## Input::::::df_cleand.csv 
## Libraries::tidyverse
## Output:::::table1_descriptive.csv, histogram_WMC3.png, histogram_WMC6.png


#Select the data column and calculate the description
table1 = df_cleaned %>%
  select(generalSophistication, MDT.ability, BAT.ability, WMC3, WMC6)
table1Vars = psych::describe(table1, na.rm = T)
table1Vars = cbind(measure = rownames(table1Vars), table1Vars) %>%
  select(measure, n, mean, median, sd, min, max, skew, kurtosis)#final descriptive table

#Plotting histograms of the distributions of WMC3 and WMC6
hist(df_cleaned$WMC3, main = "Population distribution on set size 3", xlab = "WMC3")
hist(df_cleaned$WMC6, main = "Population distribution on set size 6", xlab = "WMC6")

#### Out Put ####(Replace outfolder with a local path)
#save the final table
write.csv(table1Vars, file = "outfolder/table1_decriptive.csv", row.names = FALSE)

#save the histograms of the distributions of WMC3 and WMC6
png("outfolder/histogram_WMC3.png", width = 800, height = 600)
hist(df_cleaned$WMC3, main = "Population distribution on set size 3", xlab = "WMC3")
dev.off()

png("outfolder/histogram_WMC6.png", width = 800, height = 600)
hist(df_cleaned$WMC6, main = "Population distribution on set size 6", xlab = "WMC6")
dev.off()


####### Clean Up #######
remove(table1)
remove(table1Vars)