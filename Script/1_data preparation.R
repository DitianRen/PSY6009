#### Data cleansing and integration ####

## Input::::::MDT.csv, CABAT.csv, GOLD-MSI.csv, WMC.csv, processing.csv, demographic.csv 
## Libraries::tidyverse
## Output:::::df_cleand.csv

#Get the average of WMC on set 3 and WMC on set 6
averages <- aggregate(wmc ~ extId + setSize, data = WMC, FUN = mean)
WMC1 <- averages[averages$setSize == 3, "wmc"]
averages$WMC3 <- WMC1
WMC2 <- averages[averages$setSize == 6, "wmc"]
averages$WMC6 <- WMC2

#Get final data of average WMC3 and WMC6
final_averages <- averages[1:256, ]
final_averages <- final_averages[, c(1, 4, 5)]

#Extract the data columns to be merged
mainMDT <- MDT[, c(1, 2)]
mainCABAT <- CABAT[, c(1, 2)]
main_demo <- demographic[, c(1, 2, 3, 6, 10, 15)]

#Merge the data columns into final one table
merged1 <- merge(GOLD_MSI, final_averages, by = "extId", all = TRUE)
merged2 <- merge(merged1, mainMDT, by = "extId", all = TRUE)
merged3 <- merge(merged2, mainCABAT, by = "extId", all = TRUE)
final_data <- merge(merged3, main_demo, by = "extId", all = TRUE)

#Delete all blank data and duplicate IDs
df_cleaned <- na.omit(final_data)
df_cleaned <- df_cleaned[!duplicated(df_cleaned$extId), ]

####### Secondary Data Cleaning #######

#merge processing data
final_data <- merge(final_data, processing, by = "extId", all = TRUE)

# Exclude samples below 0.85(85%)
final_data <- final_data[final_data$processing >= 0.85, ]
df_cleaned <- na.omit(final_data)

#save the final table(Replace outfolder with a local path)
write.csv(df_cleaned, file = "outfolder/df_cleaned.csv", row.names = FALSE)


####### Clean Up #######
remove(averages)
remove(final_averages)
remove(WMC1)
remove(WMC2)
remove(merged1)
remove(merged2)
remove(merged3)
remove(MDT)
remove(CABAT)
remove(GOLD_MSI)
remove(WMC)
remove(processing)
remove(demographic)
remove(main_demo)
remove(mainCABAT)
remove(mainMDT)
remove(final_data)
remove(df_cleaned)