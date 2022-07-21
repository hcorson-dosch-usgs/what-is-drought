source('2_process/src/prep_stripswarm.R')

p2_targets <- list(
  ##### General metadata #####
  tar_target(p2_metadata,
             readr::read_csv(p1_metadata_csv, col_types=cols())),

  ##### Data for 1951-2020 #####

  ###### Get 1951-2020 metadata ######
  tar_target(p2_1951_2020_metadata,
             filter(p2_metadata, national_1951)),
  tar_target(p2_casc_list,
             # Climate Adaptation Regions
             list(NW = c('WA','OR','ID'),
                  SW = c('CA','UT','NV','NM'),
                  NC = c('MT','ND','SD','WY','CO','NE','KS'),
                  MW = c('WI','MN','IA','IN','IL','OH','MI'),
                  NE = c('ME','VT','NH','NY','NJ','MA','RI','CT','WV','VA','MD','DE','KY'),
                  SE = c('AR','MS','TN','NC','SC','AL','FL','GA','PR'),
                  PI = c('HI','AS','GU'),
                  AK = c('AK'))
             ),
  
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
             readr::read_csv(p1_1951_2020_drought_prop_site_csv, col_types = cols()) %>%
              mutate(across(c(start, end), ~as.Date(.x, '%Y-%m-%d')))
             ),
  tar_target(p2_site_prop_10,
             # Filter to 10 threshold
             p2_1951_2020_drought_summary_jd %>%
               filter(threshold == 10) %>%
               left_join(p2_1951_2020_metadata %>%
                           select(StaID:STATE, HCDN_2009))
             ),
  tar_target(p2_site_prop_2,
             # Filter to 10 threshold
             p2_1951_2020_drought_prop_jd_7d %>%
               filter(threshold == 2) %>%
               left_join(p2_1951_2020_metadata %>%
                           select(StaID:STATE, HCDN_2009))
  ),
  tar_target(p2_1951_2020_drought_prop_jd,
             readr::read_csv(p1_1951_2020_drought_prop_jd_csv, col_types = cols())),
  tar_target(p2_1951_2020_drought_prop_jd_7d,
             readr::read_csv(p1_1951_2020_drought_prop_jd_7d_csv, col_types = cols())),
  tar_target(p2_1951_2020_drought_prop_jd_30d,
             readr::read_csv(p1_1951_2020_drought_prop_jd_30d_csv, col_types = cols())),
  tar_target(p2_site_swarm,
             create_event_swarm(event_data = p2_site_prop_2,
                                start_period = as.Date('2010-01-01'),
                                end_period = as.Date('2020-12-31'))),

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