#### Multiple Regression ####

## Input::::::df_cleand.csv 
## Libraries::tidyverse, broom
## Output:::::table4_regression.csv


#Multiple regression between Active music-making and WMC3 & WMC6
model3 <-lm(WMC3~generalSophistication + MDT.ability + BAT.ability,data = df_cleaned)

model4 <-lm(WMC6~generalSophistication + MDT.ability + BAT.ability,data = df_cleaned)

#Combined regression results
results <- bind_rows(
  tidy(model3, conf.int = TRUE),
  tidy(model4, conf.int = TRUE))

#save the regression results(Replace outfolder with a local path)
write.csv(results, "outfolder/table4_regression.csv", row.names = FALSE)


####### Clean Up #######
remove(model3)
remove(model4)
remove(results)

remove(df_cleaned)