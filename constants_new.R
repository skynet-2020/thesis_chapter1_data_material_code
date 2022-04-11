
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ PATHS @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# density, cover for new experiment
# density_path_new_experiment = "/Users/joshuagilman/Documents/code/data/temp_data/new_density_temp.csv"
density_path_new_experiment = "/Users/joshuagilman/Documents/code/thesis/data/new_data_outfiles/new_density.csv"
cover_path_new_experiment = "/Users/joshuagilman/Documents/code/thesis/data/temp_data/new_cover.csv"

# precip
precip_path_new_experiment = "/Users/joshuagilman/Documents/code/thesis/data/new_data_outfiles/precip_daily_new.csv"

# soil temp
wp_soil_temp_new_experiment = "/Users/joshuagilman/Documents/code/thesis/data/temp_data/WP_temp_daily_new.csv"

# small-mammal data
small_mammal_path = "/Users/joshuagilman/Documents/code/thesis/data/new_data_outfiles/small_mammal.csv"

# wp for new experiment
wp_path_new_experiment = "/Users/joshuagilman/Documents/code/thesis/data/new_data_outfiles/WP_daily_new.csv"

# litter data
litter_path = "/Users/joshuagilman/Documents/code/thesis/data/Rick_litter_data/litter_2020.csv"

#photo path
tc1_photo_path = "/Users/joshuagilman/Documents/code/thesis/stats/thesis_chapter_1/thesis_chapter_1_photos/static_photos/"
tc1_figure_bw_photo_path = "/Users/joshuagilman/Documents/code/thesis/stats/thesis_chapter_1/thesis_chapter_1_photos/final_figures/"
tc2_categorical_EDA_path_2018 = "/Users/joshuagilman/Documents/code/thesis/stats/thesis_chapter_2/thesis_chapter_2_photos/figures/EDA/categorical/2018/"
tc2_categorical_EDA_path_2019 = "/Users/joshuagilman/Documents/code/thesis/stats/thesis_chapter_2/thesis_chapter_2_photos/figures/EDA/categorical/2019/"
tc2_density_EDA_path = "/Users/joshuagilman/Documents/code/thesis/stats/thesis_chapter_2/thesis_chapter_2_photos/figures/EDA/density/"
tc2_figure_color_photo_path = "/Users/joshuagilman/Documents/code/thesis/stats/thesis_chapter_2/thesis_chapter_2_photos/figures/color/"
tc2_figure_bw_photo_path = "/Users/joshuagilman/Documents/code/thesis/stats/thesis_chapter_2/thesis_chapter_2_photos/figures/bw/"

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ DATA UPLOAD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# WP
wp_daily_2018 <- read_csv(wp_path_new_experiment, 
                          col_types = cols(burn_treatment = col_factor(levels = c("burn", 
                                                                                  "re_burn")), date = col_datetime(format = "%Y-%m-%d %H-%M-%S"), block = col_factor(NULL), year = col_factor(levels = c("2017", "2018", "2019", "2020")), month = col_factor(NULL), sensor_assignment = col_factor(NULL),
                                           precip_treatment = col_factor(levels = c("drought", 
                                                                                    "pulse", "control", "post_control")), propagule_pressure = col_factor(NULL), rodent_treatment = col_factor(levels = c("rodent_control", "rodent_exclusion"))))
           
                                                                                                                                                                                                          

                                                                                                                                                                                                                                                                                                                                                                  
# Soil Temp
wp_daily_temp_new <- read_csv(wp_soil_temp_new_experiment, 
                              col_types = cols(burn_treatment = col_factor(levels = c("burn", 
                                                                                      "re_burn")), date = col_datetime(format = "%Y-%m-%d %H-%M-%S"), block = col_factor(NULL), year = col_factor(levels = c("2017", "2018", "2019", "2020")), month = col_factor(NULL), sensor_assignment = col_factor(NULL),
                                               precip_treatment = col_factor(levels = c("drought", 
                                                                                        "pulse", "control", "post_control")), rodent_treatment = col_factor(levels = c("rodent_control", 
                                                                                                                                                                       "rodent_exclusion"))))

# litter data
litter <- read_csv(litter_path, col_types = cols(burn_treatment = col_factor(levels = c("burn", "re_burn")),  precip_treatment = col_factor(levels = c("drought", "pulse")), rodent_treatment = col_factor(levels = c("rodent_control", "rodent_exclusion")), 
                                                 block = col_factor(NULL), year = col_factor(NULL), sensor_assignment = col_factor(NULL)))
                                                 
                                                                                                                                                                                                                      
                                                                                        

# shelter cover
cover_new <- read_csv(cover_path_new_experiment, col_types = cols(shelter = col_factor(NULL), datalogger = col_factor(NULL), year = col_factor(levels = c("2017", "2018", "2019", "2020"))))

# shelter density
density_new <- read_csv(density_path_new_experiment, col_types = cols(shelter = col_factor(NULL), whole_plot = col_factor(NULL), split_plot = col_factor(NULL), datalogger = col_factor(NULL), rodent_treatment = col_factor(levels = c("rodent_control", 
                                                                                                                                                                          "rodent_exclusion")), block = col_factor(NULL)))
small_mammal <- read_csv(small_mammal_path, col_types = cols(burn_treatment = col_factor(levels = c("unburned", "burned", "control")), rodent_treatment = col_factor(levels = c("rodent_control", "rodent_exclusion", "control")), block = col_factor(levels = c("1", "2", "3", "4", "5")), year = col_factor(levels = c("2017", "2018", "2019", "2020")), species = col_factor(NULL), trapping_season = col_factor(NULL), plot = col_factor(NULL)))
                                                                                                                                            

# precipitation data
precip_new <- read_csv(precip_path_new_experiment, col_types = cols(daily_sum = col_double(), season = col_factor(levels = c("pre_growth", "growth", "post_growth", "summer", "fall", "winter")), date = col_datetime(format = "%Y-%m-%d %H-%M-%S")))

print("done with data upload")

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ useful dataframes @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# join shelter cover, density data
shelter_cover_density_new_joined <- cover_new %>%
  merge(., density_new, by = c("shelter","year")) 


model_veg <- shelter_cover_density_new_joined %>% 
  mutate(BRTE_density_sqrt = sqrt(BRTE_density)) %>% 
  mutate(BRTE_density_sqrt_sqrt = sqrt(BRTE_density_sqrt)) %>% 
  mutate(ELEL_density_sqrt = sqrt(ELEL_density)) %>% 
  mutate(CETE_density_sqrt = sqrt(CETE_density)) %>% 
  mutate(BRTE_canopy_cover_sqrt = sqrt(BRTE_canopy_cover)) %>% 
  mutate(ELEL_canopy_cover_sqrt = sqrt(ELEL_canopy_cover)) %>% 
  mutate(CETE_canopy_cover_sqrt = sqrt(CETE_canopy_cover)) %>% 
  mutate(total_canopy_coper_sqrt = sqrt(total_canopy_cover)) %>% 
  filter(precip_treatment != "control" & precip_treatment != "post_control") %>% 
  filter(block != 1 & block != 4) %>% 
  droplevels()%>% 
  mutate(total_density = BRTE_density + CETE_density + ELEL_density + LEPE_density + DEPI_density + ALAL_density)



print("pf_value")
wp_new_logged <- wp_daily_2018 %>%
  mutate(date = as.Date(date)) %>% 
  filter(sensor_assignment != "5G0E3704.3" & sensor_assignment != "5G0F4358.3" & sensor_assignment != "5G0E3562.3") %>%
  mutate(daily_average_logged = -1*(log10(-1*(daily_average)))) %>%
  mutate(pF = log10(-1*(10.1972*daily_average))) %>% 
  mutate(ppF = log10(-1*(0.0981*daily_average)))

  

wp_daily_temp <- wp_daily_temp_new %>% 
  filter(sensor_assignment != "5G0E3704.3" & sensor_assignment != "5G0F4358.3" & sensor_assignment != "5G0E3562.3") %>% 
  mutate(date = as.Date(date))

precip_new_calibrated <- precip_new %>%
  mutate(date = as.Date(date)) %>% 
  mutate(daily_sum_calibrated = (daily_sum)*0.254)


# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ models @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@











# NOTES

# In the raw data, there is an edge case where a sensor got installed in the wrong port. In early spring of 2020, a rodent chewed through all the cables of datalogger 5G0E3728. 
# When I went to fix the problem (installing new cables) I must have accidentally installed a sensor in port 5. There has never been a sensor in port 5. There is no
# information on port 5 in the lookup table. Therefore, I deleted the information gathered in port 5 from logger 5G0E3728 from the datafile in Rush20200904. 
# If new data is imported, this must be deleted again, or it will get messed up again che. 





# 
#  pF = log10(abs(10.1972*daily_average[-kPa]))
#  ppF = log10(abs(0.0981*daily_average[-kPa]))

