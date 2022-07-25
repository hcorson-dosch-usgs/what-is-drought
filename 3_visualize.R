source('3_visualize/src/plot_stripswarm.R')
source('3_visualize/src/drought_learner_viz.R')

p3_targets <- list(
  # Recreate shamshaw's strip swarm chart, but with more sites
  tar_target(
    p3_swarm_1980_2020,
    event_swarm_plot(swarm_data = p2_site_swarm)
  ),
  tar_target(p3_swarm_national_png,
             ggsave('3_visualize/out/swarm_test.png', 
                    p3_swarm_1980_2020,
                    width = 14, height = 10, dpi = 300),
             format = "file" ),
             
  #### Creates a series of ggplot pngs that will get pulled together downstream
  #
  # NOTE: Must make sure that target 'p2_1951_2020_metadata_subset' includes the correct data
  #
  tar_target(p3_drought_learner_viz01_png,
             drought_lrnr_viz01(p2_droughts_learner_viz_df,
                                p2_streamflow_learner_viz_df,
                                out_png = "3_visualize/out/drought_learner_01.png"),
             format = "file"),
  
  tar_target(p3_drought_learner_viz02_png,
             drought_lrnr_viz01(p2_droughts_learner_viz_df,
                                p2_streamflow_learner_viz_df,
                                out_png = "3_visualize/out/drought_learner_02.png"),
             format = "file"),
  
  # Wrap up all the frames into a tibble that has filepaths 
  # to each of the exported pngs for each frame, 
  # and a variable with the numeric sequencing of the pngs
  tar_target(p3_learner_viz_tibble,
             tibble(filepaths = c(p3_drought_learner_viz01_png, p3_drought_learner_viz02_png),
                    frame_number = 1:length(filepaths)))
)

