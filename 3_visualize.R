source('3_visualize/src/drought_learner_viz.R')

p3_targets <- list(
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
