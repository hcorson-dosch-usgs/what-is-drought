source('3_visualize/src/drought_learner_viz_components.R')

p3_targets <- list(
       
  
  # Global design variables to be used in each frame, with "dv_" as prefix for "design variable"
  tar_target(p3_dv_tibble,
             tibble(
               # Drought events
               dv_drought_fill = "#ffE3ad",
               dv_drought_threshold = "#ffE3ad",
               dv_drought_text_color = "#ffE3ad",
               dv_threshold_line_size = 0.5, #default = 0.5
               df_fill_outline_color = "#ffE3ad",
               dv_fill_outline_size = 0, #0.05
               # Streamflow
               dv_streamflow_line_color = "#132B69",
               dv_streamflow_text_color = "#132B69",
               dv_streamflow_fade_color = "#3F7296",
               dv_streamflow_line_size = 0.2, #default = 0.5
               # Other Annotations
               dv_circle_explainer = "#000000",
               # png sizing,
               dv_png_width = 1200, 
               dv_png_height = 800,
               # Base plot design
               dv_basePlot_axis_text_color = "#a2d7d3",
               dv_basePlot_axis_fill_color = "#a2d7d3"
             )
  ),
  
  
  
  #### Creates a series of ggplot pngs that will get pulled together downstream
  #
  # NOTE: Must make sure that target 'p2_1951_2020_metadata_subset' includes the correct data
  #

    # This is for most frames, focused on growing season
  tar_target(p3_blank_plot_summer,
             blank_plot(streamflow_df = p2_streamflow_learner_viz_df,
                        dv_tibble = p3_dv_tibble,
                        growing_season = T)),
  
    # This is for the frames showing a whole year
  tar_target(p3_blank_plot_year,
             blank_plot(streamflow_df = p2_streamflow_learner_viz_df,
                        dv_tibble = p3_dv_tibble,
                        growing_season = F)),
  
  # Inset maps
      # view = "CONUS" excludes Alaska and Hawaii
      # view = "midwest" zooms in on midwest states
  tar_target(p3_map_midwest,
             inset_map(state_fill = "#1E466E",
                       border_size = 0.05,
                       border_color = "#5BA5B3",
                       highlight_site_color = "#ec8176",
                       view = "midwest")),
  tar_target(p3_inset_map,
             inset_map(state_fill = "#1E466E",
                       border_size = 0.05,
                       border_color = "#1E466E",
                       highlight_site_color = "#fcee21",
                       view = "CONUS")),

  
  
  # Frames 
  tar_target(p3_drought_learner_viz_a_png,
             frame_a(blank_plot = p3_blank_plot_summer,
                     streamflow_df = p2_streamflow_learner_viz_df,
                     droughts_df = p2_droughts_learner_viz_df,
                     inset = p3_map_midwest,
                     canvas = p3_canvas,
                     out_png = "src/assets/images/threshold-chart/a.png",
                     dv_tibble = p3_dv_tibble),
             format = "file"),
  
  tar_target(p3_drought_learner_viz_b_png,
             frame_b(blank_plot = p3_blank_plot_summer,
                     streamflow_df = p2_streamflow_learner_viz_df,
                     droughts_df = p2_droughts_learner_viz_df,
                     inset = p3_map_midwest,
                     canvas = p3_canvas,
                     out_png = "src/assets/images/threshold-chart/b.png",
                     dv_tibble = p3_dv_tibble),
             format = "file"),
  
  tar_target(p3_drought_learner_viz_c_png,
             frame_c(blank_plot = p3_blank_plot_summer,
                     streamflow_df = p2_streamflow_learner_viz_df,
                     droughts_df = p2_droughts_learner_viz_df,
                     inset = p3_inset_map,
                     canvas = p3_canvas,
                     out_png = "src/assets/images/threshold-chart/c.png",
                     dv_tibble = p3_dv_tibble),
             format = "file"),
  
  tar_target(p3_drought_learner_viz_d_png,
             frame_d(blank_plot = p3_blank_plot_summer,
                     streamflow_df = p2_streamflow_learner_viz_df,
                     droughts_df = p2_droughts_learner_viz_df,
                     inset = p3_inset_map,
                     canvas = p3_canvas,
                     out_png = "src/assets/images/threshold-chart/d.png",
                     dv_tibble = p3_dv_tibble),
             format = "file"),
  
  tar_target(p3_drought_learner_viz_f_png,
             frame_e(blank_plot = p3_blank_plot_summer,
                     streamflow_df = p2_streamflow_learner_viz_df,
                     droughts_df = p2_droughts_learner_viz_df,
                     inset = p3_inset_map,
                     canvas = p3_canvas,
                     out_png = "src/assets/images/threshold-chart/e.png",
                     dv_tibble = p3_dv_tibble),
             format = "file"),
  
  tar_target(p3_drought_learner_viz_g_png,
             frame_f(blank_plot = p3_blank_plot_summer,
                     streamflow_df = p2_streamflow_learner_viz_df,
                     droughts_df = p2_droughts_learner_viz_df,
                     inset = p3_inset_map,
                     canvas = p3_canvas,
                     out_png = "src/assets/images/threshold-chart/f.png",
                     dv_tibble = p3_dv_tibble),
             format = "file"),
  
  tar_target(p3_drought_learner_viz_h_png,
             frame_g(blank_plot = p3_blank_plot_summer,
                     streamflow_df = p2_streamflow_learner_viz_df,
                     droughts_df = p2_droughts_learner_viz_df,
                     inset = p3_inset_map,
                     canvas = p3_canvas,
                     out_png = "src/assets/images/threshold-chart/g.png",
                     dv_tibble = p3_dv_tibble),
             format = "file"),
  
  tar_target(p3_drought_learner_viz_i_png,
             frame_h(blank_plot = p3_blank_plot_summer,
                     streamflow_df = p2_streamflow_learner_viz_df,
                     droughts_df = p2_droughts_learner_viz_df,
                     inset = p3_inset_map,
                     canvas = p3_canvas,
                     out_png = "src/assets/images/threshold-chart/h.png",
                     dv_tibble = p3_dv_tibble),
             format = "file"),
  
  tar_target(p3_drought_learner_viz_j_png,
             frame_i(blank_plot = p3_blank_plot_summer,
                     streamflow_df = p2_streamflow_learner_viz_df,
                     droughts_df = p2_droughts_learner_viz_df,
                     inset = p3_inset_map,
                     canvas = p3_canvas,
                     out_png = "src/assets/images/threshold-chart/i.png",
                     dv_tibble = p3_dv_tibble),
             format = "file"),
  
  tar_target(p3_drought_learner_viz_k_png,
             frame_j(blank_plot = p3_blank_plot_summer,
                     streamflow_df = p2_streamflow_learner_viz_df,
                     droughts_df = p2_droughts_learner_viz_df,
                     inset = p3_inset_map,
                     canvas = p3_canvas,
                     out_png = "src/assets/images/threshold-chart/j.png",
                     dv_tibble = p3_dv_tibble),
             format = "file"),
  
  tar_target(p3_drought_learner_viz_l_png,
             frame_k(blank_plot = p3_blank_plot_year,
                     streamflow_df = p2_streamflow_learner_viz_df,
                     droughts_df = p2_droughts_learner_viz_df,
                     inset = p3_inset_map,
                     canvas = p3_canvas,
                     out_png = "src/assets/images/threshold-chart/k.png",
                     dv_tibble = p3_dv_tibble),
             format = "file"),
  
  tar_target(p3_drought_learner_viz_m_png,
             frame_l(blank_plot = p3_blank_plot_year,
                     streamflow_df = p2_streamflow_learner_viz_df, 
                     droughts_df = p2_droughts_learner_viz_df,
                     droughts_70yr_site_df = p2_droughts_70year_stacked_site_df, 
                     droughts_70yr_j7_df = p2_droughts_70year_stacked_j7_df, 
                     canvas = p3_canvas, 
                     out_png = "src/assets/images/threshold-chart/l.png",
                     dv_tibble = p3_dv_tibble),
             format = "file")
)

