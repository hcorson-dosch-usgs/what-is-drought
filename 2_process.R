ource('2_process/src/prep_stripswarm.R')

p2_targets <- list(
  ##### General metadata #####
  tar_target(p2_metadata,
             readr::read_csv(p1_metadata_csv, col_types=cols())),

  ##### Data for 1951-2020 #####

  ###### Get 1951-2020 metadata ######
  tar_target(p2_1951_2020_metadata,
             filter(p2_metadata, national_1951)),
  
  ###### Load drought summaries ######
  tar_target(p2_1951_2020_drought_summary_site,
             readr::read_csv(p1_1951_2020_drought_summary_site_csv, col_types = cols())),
  tar_target(p2_1951_2020_drought_summary_jd,
             readr::read_csv(p1_1951_2020_drought_summary_jd_csv, col_types = cols())),
  tar_target(p2_1951_2020_drought_summary_jd_7d,
             readr::read_csv(p1_1951_2020_drought_summary_jd_7d_csv, col_types = cols())),
  tar_target(p2_1951_2020_drought_summary_jd_30d,
             readr::read_csv(p1_1951_2020_drought_summary_jd_30d_csv, col_types = cols())),
  
  ###### Load streamflow auditing ######
  tar_target(p2_1951_2020_streamflow_audit,
             readr::read_csv(p1_1951_2020_streamflow_audit_csv, col_types = cols())),
  
  ###### Load drought properties ######
  tar_target(p2_1951_2020_drought_prop_site,
             readr::read_csv(p1_1951_2020_drought_prop_site_csv, col_types = cols())),
  tar_target(p2_1951_2020_drought_prop_jd,
             readr::read_csv(p1_1951_2020_drought_prop_jd_csv, col_types = cols())),
  tar_target(p2_1951_2020_drought_prop_jd_7d,
             readr::read_csv(p1_1951_2020_drought_prop_jd_7d_csv, col_types = cols())),
  tar_target(p2_1951_2020_drought_prop_jd_30d,
             readr::read_csv(p1_1951_2020_drought_prop_jd_30d_csv, col_types = cols())),

  ###### Load annual stats ######
  tar_target(p2_1951_2020_annual_stats_site,
             readr::read_csv(p1_1951_2020_annual_stats_site_csv, col_types = cols())),
  tar_target(p2_1951_2020_annual_stats_jd,
             readr::read_csv(p1_1951_2020_annual_stats_jd_csv, col_types = cols())),
  
  ###### Load streamflow percentile data ######
  # Only load for subset of sites
  tar_target(p2_1951_2020_metadata_subset,
             p2_1951_2020_metadata %>% slice(1:5)),
  tar_target(p2_1951_2020_streamflow_perc_file_tibble,
             p2_1951_2020_metadata_subset %>%
               select(StaID) %>%
               left_join(p1_1951_2020_streamflow_perc_csvs_tibble, by='StaID')),
  tar_target(p2_1951_2020_streamflow_perc,
             purrr::map_df(p2_1951_2020_streamflow_perc_file_tibble$flow_perc_fl, ~readr::read_csv(.x, col_types=cols())))
)