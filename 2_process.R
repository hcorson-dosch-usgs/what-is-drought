source('2_process/src/df_for_drought_learner_viz.R')

p2_targets <- list(
  ##### General metadata #####
  tar_target(p2_metadata,
             readr::read_csv(p1_metadata_csv, col_types=cols())),

  ##### Data for 1951-2020 #####

  ###### Get 1951-2020 metadata ######
  tar_target(p2_1951_2020_metadata,
             filter(p2_metadata, national_1951)),
  
  ###### Load drought properties ######
  tar_target(p2_1951_2020_drought_prop_site,
             readr::read_csv(p1_1951_2020_drought_prop_site_csv, col_types = cols()) %>%
              mutate(across(c(start, end), ~as.Date(.x, '%Y-%m-%d')))),
  tar_target(p2_1951_2020_drought_prop_jd_7d,
             readr::read_csv(p1_1951_2020_drought_prop_jd_7d_csv, col_types = cols()) %>%
               mutate(across(c(start, end), ~as.Date(.x, '%Y-%m-%d')))),
  
  ###### Load streamflow percentile data ######
  # Only load for subset of sites
  tar_target(p2_1951_2020_metadata_subset,
             p2_1951_2020_metadata %>% filter(StaID %in% c("01436000", "03221000"))),
  tar_target(p2_1951_2020_streamflow_perc_file_tibble,
             p2_1951_2020_metadata_subset %>%
               select(StaID) %>%
               left_join(p1_1951_2020_streamflow_perc_csvs_tibble, by='StaID')),
  tar_target(p2_1951_2020_streamflow_perc,
             purrr::map_df(p2_1951_2020_streamflow_perc_file_tibble$flow_perc_fl, ~readr::read_csv(.x, col_types=cols()))),
  
  ###### Process data for the drought learner viz ####
  # The df that has the drought properties by method (variable vs fixed)
  tar_target(p2_droughts_learner_viz_df,
             prep_drought_df_lrnr_viz(StationID = '03221000',
                                      focal_year = 1963,
                                      df_1951_2020_drought_prop_site = p2_1951_2020_drought_prop_site,
                                      df_1951_2020_drought_prop_jd_7d = p2_1951_2020_drought_prop_jd_7d)),
  # The df that has the streamflow values and thresholds by day
  tar_target(p2_streamflow_learner_viz_df,
             prep_streamflow_df_lrnr_viz(StationID = '03221000',
                                         focal_year = 1963,
                                         df_1951_2020_metadata = p2_1951_2020_metadata,
                                         df_1951_2020_streamflow_perc = p2_1951_2020_streamflow_perc)),
  # The df that has the drought properties by decade across all 70 years and method
  tar_target(p2_droughts_70year_learner_viz_df,
             prep_droughts_70year_learner_viz(StationID = '03221000',
                                              df_1951_2020_drought_prop_jd_7d = p2_1951_2020_drought_prop_jd_7d,
                                              df_1951_2020_drought_prop_site = p2_1951_2020_drought_prop_site)),

  # The df that stacks all droughts by DOY
    # fixed threshold
  tar_target(p2_droughts_70year_stacked_site_df,
             p2_droughts_stacked_byDOY_df(droughts_prop_target = p2_1951_2020_drought_prop_site, 
                                          StationID = '03221000', 
                                          example_threshold = 10)),
  
  # fixed threshold
  tar_target(p2_droughts_70year_stacked_j7_df,
             p2_droughts_stacked_byDOY_df(droughts_prop_target = p2_1951_2020_drought_prop_jd_7d, 
                                          StationID = '03221000', 
                                          example_threshold = 10))
  )
