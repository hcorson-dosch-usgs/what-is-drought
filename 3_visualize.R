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
             drought_lrnr_viz02(p2_droughts_learner_viz_df,
                                p2_streamflow_learner_viz_df,
                                out_png = "3_visualize/out/drought_learner_02.png"),
             format = "file"),
  
  tar_target(p3_drought_learner_viz03_png,
             drought_lrnr_viz03(p2_droughts_learner_viz_df,
                                p2_streamflow_learner_viz_df,
                                out_png = "3_visualize/out/drought_learner_03.png"),
             format = "file"),
  
  tar_target(p3_drought_learner_viz04_png,
             drought_lrnr_viz04(p2_droughts_learner_viz_df,
                                p2_streamflow_learner_viz_df,
                                out_png = "3_visualize/out/drought_learner_04.png"),
             format = "file"),
  
  tar_target(p3_drought_learner_viz05_png,
             drought_lrnr_viz05(p2_droughts_learner_viz_df,
                                p2_streamflow_learner_viz_df,
                                out_png = "3_visualize/out/drought_learner_05.png"),
             format = "file"),
  
  tar_target(p3_drought_learner_viz06_png,
             drought_lrnr_viz06(p2_droughts_learner_viz_df,
                                p2_streamflow_learner_viz_df,
                                out_png = "3_visualize/out/drought_learner_06.png"),
             format = "file"),
  
  tar_target(p3_drought_learner_viz07_png,
             drought_lrnr_viz07(p2_droughts_learner_viz_df,
                                p2_streamflow_learner_viz_df,
                                out_png = "3_visualize/out/drought_learner_07.png"),
             format = "file"),
  
  # Wrap up all the frames into a tibble that has filepaths 
  # to each of the exported pngs for each frame, 
  # and a variable with the numeric sequencing of the pngs
  tar_target(p3_learner_viz_tibble,
             tibble(filepaths = c(p3_drought_learner_viz01_png, p3_drought_learner_viz02_png),
                    frame_number = 1:length(filepaths)))
)
