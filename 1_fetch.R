source("1_fetch/src/sb_fetch_helpers.R")

p1_targets <- list(
  ##### Fetch data from parent item #####
  tar_target(p1_metadata_csv,
             download_sb_files(sb_id = p0_sbitem_parent,
                               sb_files_to_download = 'gagesII_metadata_study.csv',
                               dest_dir = "1_fetch/out",
                               sb_secret_exists = p0_sb_credentials_exist)
  ),
  
  ##### Fetch data from child item 1951-2020 #####
  
  ###### Download drought summary files ######
  tar_target(p1_1951_2020_drought_summary_site_csv, {
    # Depend on this dummy variable to initiate re-download of files
    p0_sb_fetch_date
    download_sb_files(sb_id = p0_sbitem_child_1951_2020,
                      sb_files_to_download = 'Drought_Summary_site.csv',
                      dest_dir = "1_fetch/out/CONUS_1951_2020",
                      sb_secret_exists = p0_sb_credentials_exist)
  },
  format = 'file'),
  tar_target(p1_1951_2020_drought_summary_jd_csv, {
    # Depend on this dummy variable to initiate re-download of files
    p0_sb_fetch_date
    download_sb_files(sb_id = p0_sbitem_child_1951_2020,
                      sb_files_to_download = 'Drought_Summary_jd.csv',
                      dest_dir = "1_fetch/out/CONUS_1951_2020",
                      sb_secret_exists = p0_sb_credentials_exist)
  },
  format = 'file'),
  tar_target(p1_1951_2020_drought_summary_jd_7d_csv, {
    # Depend on this dummy variable to initiate re-download of files
    p0_sb_fetch_date
    download_sb_files(sb_id = p0_sbitem_child_1951_2020,
                      sb_files_to_download = 'Drought_Summary_jd_07d_wndw.csv',
                      dest_dir = "1_fetch/out/CONUS_1951_2020",
                      sb_secret_exists = p0_sb_credentials_exist)
  },
  format = 'file'),
  tar_target(p1_1951_2020_drought_summary_jd_30d_csv, {
    # Depend on this dummy variable to initiate re-download of files
    p0_sb_fetch_date
    download_sb_files(sb_id = p0_sbitem_child_1951_2020,
                      sb_files_to_download = 'Drought_Summary_jd_30d_wndw.csv',
                      dest_dir = "1_fetch/out/CONUS_1951_2020",
                      sb_secret_exists = p0_sb_credentials_exist)
  },
  format = 'file'),
  

  
  ###### Download drought properties files ######
  tar_target(p1_1951_2020_drought_prop_site_csv, {
    # Depend on this dummy variable to initiate re-download of files
    p0_sb_fetch_date
    download_sb_files(sb_id = p0_sbitem_child_1951_2020,
                      sb_files_to_download = 'Drought_Properties_site_updated.csv',
                      dest_dir = "1_fetch/out/CONUS_1951_2020",
                      sb_secret_exists = p0_sb_credentials_exist)
  },
  format = 'file'),
  tar_target(p1_1951_2020_drought_prop_jd_csv, {
    # Depend on this dummy variable to initiate re-download of files
    p0_sb_fetch_date
    download_sb_files(sb_id = p0_sbitem_child_1951_2020,
                      sb_files_to_download = 'Drought_Properties_jd_updated.csv',
                      dest_dir = "1_fetch/out/CONUS_1951_2020",
                      sb_secret_exists = p0_sb_credentials_exist)
  },
  format = 'file'),
  tar_target(p1_1951_2020_drought_prop_jd_7d_csv, {
    # Depend on this dummy variable to initiate re-download of files
    p0_sb_fetch_date
    download_sb_files(sb_id = p0_sbitem_child_1951_2020,
                      sb_files_to_download = 'Drought_Properties_jd_07d_wndw_updated.csv',
                      dest_dir = "1_fetch/out/CONUS_1951_2020",
                      sb_secret_exists = p0_sb_credentials_exist)
  },
  format = 'file'),
  tar_target(p1_1951_2020_drought_prop_jd_30d_csv, {
    # Depend on this dummy variable to initiate re-download of files
    p0_sb_fetch_date
    download_sb_files(sb_id = p0_sbitem_child_1951_2020,
                      sb_files_to_download = 'Drought_Properties_jd_30d_wndw_updated.csv',
                      dest_dir = "1_fetch/out/CONUS_1951_2020",
                      sb_secret_exists = p0_sb_credentials_exist)
  },
  format = 'file'),
  
  ###### Download annual stats files ######
  tar_target(p1_1951_2020_annual_stats_site_csv, {
    # Depend on this dummy variable to initiate re-download of files
    p0_sb_fetch_date
    download_sb_files(sb_id = p0_sbitem_child_1951_2020,
                      sb_files_to_download = 'annual_stats_weibull_site.csv',
                      dest_dir = "1_fetch/out/CONUS_1951_2020",
                      sb_secret_exists = p0_sb_credentials_exist)
  },
  format = 'file'),
  
  tar_target(p1_1951_2020_annual_stats_jd_csv, {
    # Depend on this dummy variable to initiate re-download of files
    p0_sb_fetch_date
    download_sb_files(sb_id = p0_sbitem_child_1951_2020,
                      sb_files_to_download = 'annual_stats_weibull_jd.csv',
                      dest_dir = "1_fetch/out/CONUS_1951_2020",
                      sb_secret_exists = p0_sb_credentials_exist)
  },
  format = 'file'),
  
  ###### Download streamflow percentile files ######
  
  tar_target(p1_1951_2020_streamflow_perc_zip, {
    # Depend on this dummy variable to initiate re-download of files
    p0_sb_fetch_date
    download_sb_files(sb_id = p0_sbitem_child_1951_2020,
                      sb_files_to_download = 'Streamflow_percentiles_national_1951.zip',
                      dest_dir = "1_fetch/tmp",
                      sb_secret_exists = p0_sb_credentials_exist)
  },
  format = 'file'),

  tar_target(p1_1951_2020_streamflow_perc_csvs, {
    utils::unzip(zipfile = p1_1951_2020_streamflow_perc_zip,
                 exdir = "1_fetch/out/CONUS_1951_2020/streamflow_percentiles", junkpaths = TRUE)
    file.path('1_fetch/out/CONUS_1951_2020/streamflow_percentiles', 
              utils::unzip(zipfile = p1_1951_2020_streamflow_perc_zip, list = T)
              %>% pull(Name) %>% basename())
  },
  format = 'file'),
  
  tar_target(p1_1951_2020_streamflow_perc_csvs_tibble,
             tibble(
               flow_perc_fl = p1_1951_2020_streamflow_perc_csvs,
               flow_perc_fl_hash = tools::md5sum(flow_perc_fl),
               StaID = tools::file_path_sans_ext(basename(flow_perc_fl))
             ))
)