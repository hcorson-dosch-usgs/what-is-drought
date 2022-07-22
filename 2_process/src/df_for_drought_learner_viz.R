#' @description Function that combines the droughts as defined as "severe" (10%) for a give
#' site and year and for the two methods: site-specific thresholds or variable thresholds defined
#' by a 7 day floating window
#' @param StationID char, Gage identifier 
#' @param focal_year num, year of interest
#' @param p2_1951_2020_drought_prop_site df, the droughts as defined by the fixed, site-specific thresholds
#' @param p2_1951_2020_drought_prop_jd_7d df, the droughts as defined by the variable thresholds with 
#' a seven-day floating window (3 days on either side of a specific day)
prep_drought_df_lrnr_viz <- function(StationID, focal_year,
                                     p2_1951_2020_drought_prop_site,
                                     p2_1951_2020_drought_prop_jd_7d) {
  
  # Filter and simplify data to include only OH station and only 10% threshold and only 1963
  p2_droughts_site <- p2_1951_2020_drought_prop_site %>%
    filter(StaID == StationID, year(start) == focal_year, threshold == 10) %>%
    select(drought_id, duration, start, end, StaID, threshold) %>%
    mutate("method" = "fixed")
  p2_droughts_j7 <- p2_1951_2020_drought_prop_jd_7d %>%
    filter(StaID == StationID, year(start) == focal_year, threshold == 10) %>%
    select(drought_id, duration, start, end, StaID, threshold) %>% 
    mutate("method" = "variable")
  
  # Bind together
  p2_droughts_learner_viz_df <- bind_rows(p2_droughts_site, p2_droughts_j7)
  
  return(p2_droughts_learner_viz_df)
}

#' @description Function that takes a focal year and site (StaID) and cleans and combines the
#' streamflow percentiles and metadata to be ready for plotting in the drought learner viz
#' @param StationID char, Gage identifier 
#' @param focal_year num, year of interest
#' @param p2_1951_2020_metadata df, contains metadata about each station/gage, including 
#' station name, etc
#' @param p2_p2_1951_2020_streamflow_perc df, contains the streamflow values by year and 
#' date for the stations, including also the thresholds used to define drought and the
#' percentiles for each day's streamflow value based on the thresholds
prep_streamflow_df_lrnr_viz <- function(StationID, focal_year,
                                        p2_1951_2020_metadata,
                                        p2_1951_2020_streamflow_perc) {
  
  # First, only the focal site and year to create basic df
  p2_streamflow <- p2_1951_2020_streamflow_perc %>% 
    # by site and year
    filter(StaID == StationID, year == focal_year) %>%
    select(dt, value, year, jd, thresh_10_site, thresh_10_jd_07d_wndw, StaID)
  
  # Second, calculate average streamflow by day of year
  p2_streamflow_averages <- p2_1951_2020_streamflow_perc %>%
    # By site and year
    filter(StaID == StationID) %>%
    # Summarize by day of year (julian day)
    group_by(jd) %>%
    summarise(mean_flow = mean(value))
  
  # Third extract station name from metadata
  p2_streamflow <- p2_streamflow %>%
    left_join(p2_1951_2020_metadata %>% select(StaID, STANAME, STATE), by = "StaID")
  
  # Finally add in the averages to the main df
  p2_prep_streamflow_df_lrnr_viz <- p2_streamflow %>% 
    left_join(p2_streamflow_averages, by = "jd")
  
  return(p2_prep_streamflow_df_lrnr_viz)
}
