# This script takes the whopping-huge historical file of EMS database,
# which you can download on the BC Data Catalogue website 
# (https://catalogue.data.gov.bc.ca/dataset/bc-environmental-monitoring-system-results/resource/6aa7f376-a4d3-4fb4-a51c-b4487600d516)
# , and just keeps rows that tell us about total and dissolved calcium.

# The giant EMS database csv file should be stored here: I:/Admin/R_Scripts/Projects/ZQMussels/01_DataCleaning/data/
# The resulting smaller EMS data file is written to the same folder as the line above.

# Once the giant EMS database file has been filtered for calcium data, I would recommend deleting it (it is 5+ GB in size!)

library(tidyverse)
library(readr)

#Options file - this allows us to set our working directories for all scripts in just one file.
my_opts = read_csv("Options.csv") %>% 
  as.data.frame()

dat = read_csv_chunked(paste0(my_opts$base_dir,"01_DataCleaning/data/ems_sample_results_historic_expanded.csv"), 
                       callback = DataFrameCallback$new(function(x, pos) subset(x, PARAMETER %in% c("Calcium Total",'Calcium Dissolved'))))

write_csv(dat, paste0(my_opts$base_dir,"01_DataCleaning/data/mammoth_dataset_filtered_for_total_and_dissolved_calcium.csv"))
