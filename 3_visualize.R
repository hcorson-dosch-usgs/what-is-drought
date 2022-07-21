source('3_visualize/src/drought_learner_viz.R')

p3_targets <- list(
  #### Creates a series of ggplot pngs that will get pulled together downstream
  #
  # NOTE: Must make sure that target 'p2_1951_2020_metadata_subset' includes the correct data
  #
  tar_target(p3_drought_learner_viz01_png,
             drought_lrnr_viz01(p2_droughts_learner_viz_df,
                                p2_streamflow_learner_viz_df),
             format = "file")
)