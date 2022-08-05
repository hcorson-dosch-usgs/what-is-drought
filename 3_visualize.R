source('3_visualize/src/plot_stripswarm.R')
source('3_visualize/src/drought_learner_viz.R')

p3_targets <- list(
  # Create horizontal duration chart based on Shamshaw's CC 
  tar_target(
    p3_swarm_1980_2020,
    event_swarm_plot(swarm_data = bind_rows(p2_site_swarm, p2_site_swarm_80s))
  ),
  tar_target(p3_swarm_national_png,
             ggsave('3_visualize/out/swarm_national.png', 
                    p3_swarm_1980_2020,
                    width = 40, height = 10, dpi = 300),
             format = "file" ),
 
             
  #### Creates a series of ggplot pngs that will get pulled together downstream
  #
  # NOTE: Must make sure that target 'p2_1951_2020_metadata_subset' includes the correct data
  #
  tar_target(p3_drought_learner_viz01_png,
             drought_lrnr_viz01(p2_droughts_learner_viz_df,
                                p2_streamflow_learner_viz_df,
                                out_png = "src/assets/images/threshold-chart/a.png"),
             format = "file"),
  
  tar_target(p3_drought_learner_viz02_png,
             drought_lrnr_viz02(p2_droughts_learner_viz_df,
                                p2_streamflow_learner_viz_df,
                                out_png = "src/assets/images/threshold-chart/b.png"),
             format = "file"),
  
  tar_target(p3_drought_learner_viz03_png,
             drought_lrnr_viz03(p2_droughts_learner_viz_df,
                                p2_streamflow_learner_viz_df,
                                out_png = "src/assets/images/threshold-chart/c.png"),
             format = "file"),
  
  tar_target(p3_drought_learner_viz04_png,
             drought_lrnr_viz04(p2_droughts_learner_viz_df,
                                p2_streamflow_learner_viz_df,
                                out_png = "src/assets/images/threshold-chart/d.png"),
             format = "file"),
  
  tar_target(p3_drought_learner_viz05_png,
             drought_lrnr_viz05(p2_droughts_learner_viz_df,
                                p2_streamflow_learner_viz_df,
                                out_png = "src/assets/images/threshold-chart/e.png"),
             format = "file"),
  
  tar_target(p3_drought_learner_viz06_png,
             drought_lrnr_viz06(p2_droughts_learner_viz_df,
                                p2_streamflow_learner_viz_df,
                                out_png = "src/assets/images/threshold-chart/f.png"),
             format = "file"),
  
  tar_target(p3_drought_learner_viz07_png,
             drought_lrnr_viz07(p2_droughts_learner_viz_df,
                                p2_streamflow_learner_viz_df,
                                out_png = "src/assets/images/threshold-chart/g.png"),
             format = "file"),
  
  tar_target(p3_drought_learner_viz08_png,
             drought_lrnr_viz08(p2_droughts_70year_learner_viz_df,
                                out_png = "src/assets/images/threshold-chart/h.png"),
             format = "file"),
  
  # Wrap up all the frames into a tibble that has filepaths 
  # to each of the exported pngs for each frame, 
  # and a variable with the numeric sequencing of the pngs
  tar_target(p3_learner_viz_tibble,
             tibble(filepaths = c(p3_drought_learner_viz01_png, p3_drought_learner_viz02_png),
                    frame_number = 1:length(filepaths)))
)

