#' @description This function creates the first frame for the drought learner viz gif/video
#' @param p2_droughts_learner_viz_df df, the data that contains the drought properties for the focal 
#' period and site
#' @param p2_streamflow_learner_viz_df df, the data that contains the streamflow by date, average 
#' streamflow by day of year, and the thresholds for the focal period and site
#' @param out_png filepath, the output filepath for this viz frame
drought_lrnr_viz01 <- function(p2_droughts_learner_viz_df, p2_streamflow_learner_viz_df, out_png) {
  
  # since the fixed threshold is one static number, create it for a y-intercept and geom_hline
  fixed_threshold <- unique(p2_streamflow_learner_viz_df$thresh_10_site)
  
  ggplot(data = p2_streamflow_learner_viz_df, aes(y = value, x = dt))+
    # Add in droughts
    annotate("rect", # fixed threshold
             xmin = (p2_droughts_learner_viz_df$start[p2_droughts_learner_viz_df$method == "fixed"]),
             xmax = (p2_droughts_learner_viz_df$end[p2_droughts_learner_viz_df$method == "fixed"]),
             ymin = -Inf, ymax = Inf,
             fill = "#eeeeee", alpha = 0.8)+
    annotate("rect", # variable threshold
             xmin = (p2_droughts_learner_viz_df$start[p2_droughts_learner_viz_df$method == "variable"]),
             xmax = (p2_droughts_learner_viz_df$end[p2_droughts_learner_viz_df$method == "variable"]),
             ymin = -Inf, ymax = Inf,
             fill = "lightblue", alpha = 0.8)+
    ylim(c(0,2250))+
    # Streamflow by day
    geom_line(color = "blue")+ 
    # Streamflow by day mean across all years
    geom_line(data = p2_streamflow_learner_viz_df, aes(y = mean_flow, x = dt), color = "grey")+
    # Add in thresholds
    geom_hline(yintercept = fixed_threshold, color = "#FFCCFF")+
    geom_line(aes(y = thresh_10_jd_07d_wndw, x = dt), color = "magenta")+
    theme_bw()+
    ylab("Streamflow (cfs)")+
    xlab("Date")+
    ggtitle("Scioto River, Dublin, OH (03221000)")+
    scale_x_date(labels = date_format("%b"), limits = c(as.Date("01/04/1963",'%d/%m/%Y'), as.Date("01/11/1963",'%d/%m/%Y')))
  
  
  # Save and convert file
  ggsave(out_png, width = 1200, height = 900, dpi = 300, units = "px")
  return(out_png)
}
