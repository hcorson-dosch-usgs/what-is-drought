#' @description This function creates the first frame for the drought learner viz gif/video
#' @param p2_droughts_learner_viz_df df, the data that contains the drought properties for the focal 
#' period and site
#' @param p2_streamflow_learner_viz_df df, the data that contains the streamflow by date, average 
#' streamflow by day of year, and the thresholds for the focal period and site
#' @param out_png filepath, the output filepath for this viz frame
drought_lrnr_viz01 <- function(p2_droughts_learner_viz_df, p2_streamflow_learner_viz_df, out_png) {
  
  # since the fixed threshold is one static number, create it for a y-intercept and geom_hline
  fixed_threshold <- unique(p2_streamflow_learner_viz_df$thresh_10_site)
  

  # Main viz
  main <- ggplot(data = p2_streamflow_learner_viz_df, aes(y = value, x = dt))+
    ylim(c(0,1550))+
    # Streamflow by day mean across all years
    geom_line(data = p2_streamflow_learner_viz_df, aes(y = mean_flow, x = dt), color = "#9bd9f7")+
    
    ylab("Streamflow (cfs)")+
    xlab("1963")+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("01/05/1963",'%d/%m/%Y'), as.Date("15/10/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans")+
    theme(axis.line = element_line(color = 'black'),
          axis.text = element_text(size = 6),
          axis.title = element_text(size = 8))
  
  # Inset map
  gage_location <- usmap::us_map(regions = "county", include = 39049)
  inset <- usmap::plot_usmap(regions = "states", color = "#dadedf", size = 0.2)+
    geom_polygon(data = gage_location, aes(x = x, y = y), color = "#e6af84", fill = "#e6af84", size = 0.5)
  
  # Legend
  legend_data <- data.frame(group = rep(c("Average streamflow"), each = 6),
                    x = c(1:6),
                    y = c(11,10,11,10,11,10))
  legend <- ggplot(data = legend_data, aes(x = x, y = y, group = group))+
    geom_line(aes(color = group))+
    scale_color_manual(values = c("#9bd9f7", "#bf683c"))+
    theme_void()+
    theme(legend.position = "none")+
    ylim(c(0,11))+
    xlim(c(0,13))+
    annotate("text", label = "Average streamflow", x = 6.5, y = 10.2, hjust = 0, vjust = 0, size = 1.45)
    
    
  # Background
  color_bknd = "white"
  canvas <- grid::rectGrob(
    x = 0, y = 0, 
    width = 16, height = 9,
    gp = grid::gpar(fill = color_bknd, alpha = 1, col = color_bknd)
  )
  
  # compose final plot
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0, y = 1,
              height = 9, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0.3-0.025,
              y = 0.0,
              height = 0.95,
              width = 0.65) +
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.7,
              height = 0.3,
              width = 0.2) +
    # legend
    draw_plot(legend,
              x = 0.0,
              y = 0.15,
              height = 0.3,
              width = 0.25)+
    # Drippy
    draw_image(image = "3_visualize/in/Drippy100mod.png", 
               x = 0, 
               y = 0.8, 
               width = 0.2, 
               height = 0.2,
               hjust = 0.25, 
               vjust = 0)+
    # Explainer text
    draw_text(text = "A hydrological drought\nmeans that streamflow is\nabnormally low",
              x = 0.025,
              y = 0.6,
              hjust = 0,
              vjust = 0,
              size = 6)

  
  
  # Save and convert file
  ggsave(out_png, width = 1200, height = 600, dpi = 300, units = "px")
  return(out_png)
}


#' @description This function creates the first frame for the drought learner viz gif/video
#' @param p2_droughts_learner_viz_df df, the data that contains the drought properties for the focal 
#' period and site
#' @param p2_streamflow_learner_viz_df df, the data that contains the streamflow by date, average 
#' streamflow by day of year, and the thresholds for the focal period and site
#' @param out_png filepath, the output filepath for this viz frame
drought_lrnr_viz02 <- function(p2_droughts_learner_viz_df, p2_streamflow_learner_viz_df, out_png) {
  
  # since the fixed threshold is one static number, create it for a y-intercept and geom_hline
  fixed_threshold <- unique(p2_streamflow_learner_viz_df$thresh_10_site)
  
  
  # Main viz
  main <- ggplot(data = p2_streamflow_learner_viz_df, aes(y = value, x = dt))+
    ylim(c(0,1550))+
    # Streamflow by day mean across all years
    geom_line(data = p2_streamflow_learner_viz_df, aes(y = mean_flow, x = dt), color = "#9bd9f7")+
    # Add in thresholds
    geom_hline(yintercept = fixed_threshold, color = "#bf683c")+
    ylab("Streamflow (cfs)")+
    xlab("1963")+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("01/05/1963",'%d/%m/%Y'), as.Date("15/10/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans")+
    theme(axis.line = element_line(color = 'black'),
          axis.text = element_text(size = 6),
          axis.title = element_text(size = 8))
  
  # Inset map
  gage_location <- usmap::us_map(regions = "county", include = 39049)
  inset <- usmap::plot_usmap(regions = "states", color = "#dadedf", size = 0.2)+
    geom_polygon(data = gage_location, aes(x = x, y = y), color = "#e6af84", fill = "#e6af84", size = 0.5)
  
  # Legend
  legend_data <- data.frame(group = rep(c("Average streamflow", "Severe drought threshold"), each = 6),
                            x = c(1:6, 1:6),
                            y = c(11,10,11,10,11,10, 9,8,9,8,9,8))
  legend <- ggplot(data = legend_data, aes(x = x, y = y, group = group))+
    geom_line(aes(color = group))+
    scale_color_manual(values = c("#9bd9f7", "#bf683c"))+
    theme_void()+
    theme(legend.position = "none")+
    ylim(c(0,11))+
    xlim(c(0,13))+
    annotate("text", label = "Average streamflow", x = 6.5, y = 10.2, hjust = 0, vjust = 0, size = 1.45)+
    annotate("text", label = "Drought threshold", x = 6.5, y = 8.2, hjust = 0, vjust = 0, size = 1.45)
  
  # Background
  color_bknd = "white"
  canvas <- grid::rectGrob(
    x = 0, y = 0, 
    width = 16, height = 9,
    gp = grid::gpar(fill = color_bknd, alpha = 1, col = color_bknd)
  )
  
  # compose final plot
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0, y = 1,
              height = 9, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0.3-0.025,
              y = 0.0,
              height = 0.95,
              width = 0.65) +
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.7,
              height = 0.3,
              width = 0.2) +
    # legend
    draw_plot(legend,
              x = 0.0,
              y = 0.15,
              height = 0.3,
              width = 0.25)+
    # Drippy
    draw_image(image = "3_visualize/in/Drippy100mod.png", 
               x = 0, 
               y = 0.8, 
               width = 0.2, 
               height = 0.2,
               hjust = 0.25, 
               vjust = 0)+
    # Explainer text
    draw_text(text = 'Here, "abnormally low" is\nset as a threshold',
              x = 0.025,
              y = 0.6,
              hjust = 0,
              vjust = 0,
              size = 6)
  
  
  
  # Save and convert file
  ggsave(out_png, width = 1200, height = 600, dpi = 300, units = "px")
  return(out_png)
}


#' @description This function creates the third frame for the drought learner viz gif/video
#' @param p2_droughts_learner_viz_df df, the data that contains the drought properties for the focal 
#' period and site
#' @param p2_streamflow_learner_viz_df df, the data that contains the streamflow by date, average 
#' streamflow by day of year, and the thresholds for the focal period and site
#' @param out_png filepath, the output filepath for this viz frame
drought_lrnr_viz03 <- function(p2_droughts_learner_viz_df, p2_streamflow_learner_viz_df, out_png) {
  
  # since the fixed threshold is one static number, create it for a y-intercept and geom_hline
  fixed_threshold <- unique(p2_streamflow_learner_viz_df$thresh_10_site)
  
  
  # Main viz
  main <- ggplot(data = p2_streamflow_learner_viz_df, aes(y = value, x = dt))+
    # Add in droughts
    annotate("rect", # fixed threshold
             xmin = (p2_droughts_learner_viz_df$start[p2_droughts_learner_viz_df$method == "fixed"]),
             xmax = (p2_droughts_learner_viz_df$end[p2_droughts_learner_viz_df$method == "fixed"]),
             ymin = -Inf, ymax = Inf,
             fill = "#f0cfb5", alpha = 0.8)+
    ylim(c(0,1550))+
    # Streamflow by day mean across all years
    geom_line(data = p2_streamflow_learner_viz_df, aes(y = mean_flow, x = dt), color = "#9bd9f7")+
    
    # Add in thresholds
    geom_hline(yintercept = fixed_threshold, color = "#bf683c")+
    # Streamflow by day
    geom_line(color = "#5691e2", size = .45)+ 
    ylab("Streamflow (cfs)")+
    xlab("1963")+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("01/05/1963",'%d/%m/%Y'), as.Date("15/10/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans")+
    theme(axis.line = element_line(color = 'black'),
          axis.text = element_text(size = 6),
          axis.title = element_text(size = 8))
  
  # Inset map
  gage_location <- usmap::us_map(regions = "county", include = 39049)
  inset <- usmap::plot_usmap(regions = "states", color = "#dadedf", size = 0.2)+
    geom_polygon(data = gage_location, aes(x = x, y = y), color = "#e6af84", fill = "#e6af84", size = 0.5)
  
  # Legend
  legend_data <- data.frame(group = rep(c("Average streamflow",
                                          "Daily streamflow", "Severe drought threshold"), each = 6),
                            x = c(1:6, 1:6, 1:6),
                            y = c(11,10,11,10,11,10, 9,8,9,8,9,8, 7,6,7,6,7,6))
  legend <- ggplot(data = legend_data, aes(x = x, y = y, group = group))+
    geom_line(aes(color = group))+
    annotate("rect", xmin = 1, xmax = 6, ymin = 3, ymax = 4.5, fill = "#e6af84", alpha = 0.8)+
    scale_color_manual(values = c("#9bd9f7", "#bf683c", "#5691e2"))+
    theme_void()+
    theme(legend.position = "none")+
    ylim(c(0,11))+
    xlim(c(0,13))+
    annotate("text", label = "Average streamflow", x = 6.5, y = 10.2, hjust = 0, vjust = 0, size = 1.45)+
    annotate("text", label = "Drought threshold", x = 6.5, y = 8.2, hjust = 0, vjust = 0, size = 1.45)+
    annotate("text", label = "Daily streamflow", x = 6.5, y = 6.2, hjust = 0, vjust = 0, size = 1.45)+
    annotate("text", label = "Severe Drought", x = 6.5, y = 3.4, hjust = 0, vjust = 0, size = 1.45)
    
  
  # Background
  color_bknd = "white"
  canvas <- grid::rectGrob(
    x = 0, y = 0, 
    width = 16, height = 9,
    gp = grid::gpar(fill = color_bknd, alpha = 1, col = color_bknd)
  )
  
  # compose final plot
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0, y = 1,
              height = 9, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0.3-0.025,
              y = 0.0,
              height = 0.95,
              width = 0.65) +
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.7,
              height = 0.3,
              width = 0.2) +
    # legend
    draw_plot(legend,
              x = 0.0,
              y = 0.15,
              height = 0.3,
              width = 0.25)+
    # Drippy
    draw_image(image = "3_visualize/in/Drippy100mod.png", 
               x = 0, 
               y = 0.8, 
               width = 0.2, 
               height = 0.2,
               hjust = 0.25, 
               vjust = 0)+
    # Explainer text
    draw_text(text = 'Periods of severe drought\nhappen whenever\ndaily streamflow is\nbelow the threshold',
              x = 0.025,
              y = 0.6,
              hjust = 0,
              vjust = 0,
              size = 6)
  
  
  
  # Save and convert file
  ggsave(out_png, width = 1200, height = 600, dpi = 300, units = "px")
  return(out_png)
}


#' @description This function creates the fourth frame for the drought learner viz gif/video
#' @param p2_droughts_learner_viz_df df, the data that contains the drought properties for the focal 
#' period and site
#' @param p2_streamflow_learner_viz_df df, the data that contains the streamflow by date, average 
#' streamflow by day of year, and the thresholds for the focal period and site
#' @param out_png filepath, the output filepath for this viz frame
drought_lrnr_viz04 <- function(p2_droughts_learner_viz_df, p2_streamflow_learner_viz_df, out_png) {
  
  # since the fixed threshold is one static number, create it for a y-intercept and geom_hline
  fixed_threshold <- unique(p2_streamflow_learner_viz_df$thresh_10_site)
  
  
  # Main viz
  main <- ggplot(data = p2_streamflow_learner_viz_df, aes(y = value, x = dt))+
    # Add in droughts
    annotate("rect", # fixed threshold
             xmin = (p2_droughts_learner_viz_df$start[p2_droughts_learner_viz_df$method == "fixed"]),
             xmax = (p2_droughts_learner_viz_df$end[p2_droughts_learner_viz_df$method == "fixed"]),
             ymin = -Inf, ymax = Inf,
             fill = "#f0cfb5", alpha = 0.8)+
    annotate("rect", #highlight
             xmin = as.Date("1963-05-01"),
             xmax = as.Date("1963-07-01"),
             ymin = -Inf,
             ymax = Inf,
             fill = "#ffff99", alpha = 0.4)+
    ylim(c(0,1550))+
    # Streamflow by day mean across all years
    geom_line(data = p2_streamflow_learner_viz_df, aes(y = mean_flow, x = dt), color = "#9bd9f7")+
    
    # Add in thresholds
    geom_hline(yintercept = fixed_threshold, color = "#bf683c")+
    # Streamflow by day
    geom_line(color = "#5691e2", size = .45)+ 
    ylab("Streamflow (cfs)")+
    xlab("1963")+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("01/05/1963",'%d/%m/%Y'), as.Date("15/10/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans")+
    theme(axis.line = element_line(color = 'black'),
          axis.text = element_text(size = 6),
          axis.title = element_text(size = 8))
  
  # Inset map
  gage_location <- usmap::us_map(regions = "county", include = 39049)
  inset <- usmap::plot_usmap(regions = "states", color = "#dadedf", size = 0.2)+
    geom_polygon(data = gage_location, aes(x = x, y = y), color = "#e6af84", fill = "#e6af84", size = 0.5)
  
  # Legend
  legend_data <- data.frame(group = rep(c("Average streamflow",
                                          "Daily streamflow", "Severe drought threshold"), each = 6),
                            x = c(1:6, 1:6, 1:6),
                            y = c(11,10,11,10,11,10, 9,8,9,8,9,8, 7,6,7,6,7,6))
  legend <- ggplot(data = legend_data, aes(x = x, y = y, group = group))+
    geom_line(aes(color = group))+
    annotate("rect", xmin = 1, xmax = 6, ymin = 3, ymax = 4.5, fill = "#e6af84", alpha = 0.8)+
    scale_color_manual(values = c("#9bd9f7", "#bf683c", "#5691e2"))+
    theme_void()+
    theme(legend.position = "none")+
    ylim(c(0,11))+
    xlim(c(0,13))+
    annotate("text", label = "Average streamflow", x = 6.5, y = 10.2, hjust = 0, vjust = 0, size = 1.45)+
    annotate("text", label = "Drought threshold", x = 6.5, y = 8.2, hjust = 0, vjust = 0, size = 1.45)+
    annotate("text", label = "Daily streamflow", x = 6.5, y = 6.2, hjust = 0, vjust = 0, size = 1.45)+
    annotate("text", label = "Severe Drought", x = 6.5, y = 3.4, hjust = 0, vjust = 0, size = 1.45)
  
  
  # Background
  color_bknd = "white"
  canvas <- grid::rectGrob(
    x = 0, y = 0, 
    width = 16, height = 9,
    gp = grid::gpar(fill = color_bknd, alpha = 1, col = color_bknd)
  )
  
  # compose final plot
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0, y = 1,
              height = 9, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0.3-0.025,
              y = 0.0,
              height = 0.95,
              width = 0.65) +
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.7,
              height = 0.3,
              width = 0.2) +
    # legend
    draw_plot(legend,
              x = 0.0,
              y = 0.15,
              height = 0.3,
              width = 0.25)+
    # Drippy
    draw_image(image = "3_visualize/in/Drippy100mod.png", 
               x = 0, 
               y = 0.8, 
               width = 0.2, 
               height = 0.2,
               hjust = 0.25, 
               vjust = 0)+
    # Explainer text
    draw_text(text = 'You might be wondering,\nwhat happens if there is\nan abnormally dry spring\nwhen we expect more rain?',
              x = 0.025,
              y = 0.6,
              hjust = 0,
              vjust = 0,
              size = 6)
  
  
  
  # Save and convert file
  ggsave(out_png, width = 1200, height = 600, dpi = 300, units = "px")
  return(out_png)
}

#' @description This function creates the fifth frame for the drought learner viz gif/video
#' @param p2_droughts_learner_viz_df df, the data that contains the drought properties for the focal 
#' period and site
#' @param p2_streamflow_learner_viz_df df, the data that contains the streamflow by date, average 
#' streamflow by day of year, and the thresholds for the focal period and site
#' @param out_png filepath, the output filepath for this viz frame
drought_lrnr_viz05 <- function(p2_droughts_learner_viz_df, p2_streamflow_learner_viz_df, out_png) {
  
  # since the fixed threshold is one static number, create it for a y-intercept and geom_hline
  fixed_threshold <- unique(p2_streamflow_learner_viz_df$thresh_10_site)
  
  
  # Main viz
  main <- ggplot(data = p2_streamflow_learner_viz_df, aes(y = value, x = dt))+
    # Add in droughts
    annotate("rect", # fixed threshold
             xmin = (p2_droughts_learner_viz_df$start[p2_droughts_learner_viz_df$method == "fixed"]),
             xmax = (p2_droughts_learner_viz_df$end[p2_droughts_learner_viz_df$method == "fixed"]),
             ymin = -Inf, ymax = Inf,
             fill = "#f0cfb5", alpha = 0.3)+
    ylim(c(0,1550))+
    # Streamflow by day mean across all years
    geom_line(data = p2_streamflow_learner_viz_df, aes(y = mean_flow, x = dt), color = "#9bd9f7")+
    
    # Add in thresholds
    geom_hline(yintercept = fixed_threshold, color = "#bf683c", alpha = 0.3)+
    # Streamflow by day
    geom_line(color = "#5691e2", size = .45)+ 
    ylab("Streamflow (cfs)")+
    xlab("1963")+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("01/05/1963",'%d/%m/%Y'), as.Date("15/10/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans")+
    theme(axis.line = element_line(color = 'black'),
          axis.text = element_text(size = 6),
          axis.title = element_text(size = 8))
  
  # Inset map
  gage_location <- usmap::us_map(regions = "county", include = 39049)
  inset <- usmap::plot_usmap(regions = "states", color = "#dadedf", size = 0.2)+
    geom_polygon(data = gage_location, aes(x = x, y = y), color = "#e6af84", fill = "#e6af84", size = 0.5)
  
  # Legend
  legend_data <- data.frame(group = rep(c("Average streamflow",
                                          "Daily streamflow", "Severe drought threshold"), each = 6),
                            x = c(1:6, 1:6, 1:6),
                            y = c(11,10,11,10,11,10, 9,8,9,8,9,8, 7,6,7,6,7,6))
  legend <- ggplot(data = legend_data, aes(x = x, y = y, group = group))+
    geom_line(aes(color = group))+
    annotate("rect", xmin = 1, xmax = 6, ymin = 3, ymax = 4.5, fill = "#e6af84", alpha = 0.8)+
    scale_color_manual(values = c("#9bd9f7", "#bf683c", "#5691e2"))+
    theme_void()+
    theme(legend.position = "none")+
    ylim(c(0,11))+
    xlim(c(0,13))+
    annotate("text", label = "Average streamflow", x = 6.5, y = 10.2, hjust = 0, vjust = 0, size = 1.45)+
    annotate("text", label = "Drought threshold", x = 6.5, y = 8.2, hjust = 0, vjust = 0, size = 1.45)+
    annotate("text", label = "Daily streamflow", x = 6.5, y = 6.2, hjust = 0, vjust = 0, size = 1.45)+
    annotate("text", label = "Severe Drought", x = 6.5, y = 3.4, hjust = 0, vjust = 0, size = 1.45)
  
  
  # Background
  color_bknd = "white"
  canvas <- grid::rectGrob(
    x = 0, y = 0, 
    width = 16, height = 9,
    gp = grid::gpar(fill = color_bknd, alpha = 1, col = color_bknd)
  )
  
  # compose final plot
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0, y = 1,
              height = 9, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0.3-0.025,
              y = 0.0,
              height = 0.95,
              width = 0.65) +
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.7,
              height = 0.3,
              width = 0.2) +
    # legend
    draw_plot(legend,
              x = 0.0,
              y = 0.15,
              height = 0.3,
              width = 0.25)+
    # Drippy
    draw_image(image = "3_visualize/in/Drippy100mod.png", 
               x = 0, 
               y = 0.8, 
               width = 0.2, 
               height = 0.2,
               hjust = 0.25, 
               vjust = 0)+
    # Explainer text
    draw_text(text = 'Well, then we need\nto determine periods when\nrainfall is abnormally low\nfor a specific week',
              x = 0.025,
              y = 0.6,
              hjust = 0,
              vjust = 0,
              size = 6)
  
  
  
  # Save and convert file
  ggsave(out_png, width = 1200, height = 600, dpi = 300, units = "px")
  return(out_png)
}

#' @description This function creates the sixth frame for the drought learner viz gif/video
#' @param p2_droughts_learner_viz_df df, the data that contains the drought properties for the focal 
#' period and site
#' @param p2_streamflow_learner_viz_df df, the data that contains the streamflow by date, average 
#' streamflow by day of year, and the thresholds for the focal period and site
#' @param out_png filepath, the output filepath for this viz frame
drought_lrnr_viz06 <- function(p2_droughts_learner_viz_df, p2_streamflow_learner_viz_df, out_png) {
  
  # since the fixed threshold is one static number, create it for a y-intercept and geom_hline
  fixed_threshold <- unique(p2_streamflow_learner_viz_df$thresh_10_site)
  
  
  # Main viz
  main <- ggplot(data = p2_streamflow_learner_viz_df, aes(y = value, x = dt))+
    annotate("rect", # fixed threshold
             xmin = (p2_droughts_learner_viz_df$start[p2_droughts_learner_viz_df$method == "fixed"]),
             xmax = (p2_droughts_learner_viz_df$end[p2_droughts_learner_viz_df$method == "fixed"]),
             ymin = -Inf, ymax = Inf,
             fill = "#f0cfb5", alpha = 0.3)+

    ylim(c(0,1550))+
    # Streamflow by day mean across all years
    geom_line(data = p2_streamflow_learner_viz_df, aes(y = mean_flow, x = dt), color = "#9bd9f7")+
    
    # Add in thresholds
    geom_hline(yintercept = fixed_threshold, color = "#bf683c", alpha = 0.3)+
    geom_line(aes(y = thresh_10_jd_07d_wndw, x = dt), color = "#c1272d")+
    # Streamflow by day
    geom_line(color = "#5691e2", size = .45)+ 
    ylab("Streamflow (cfs)")+
    xlab("1963")+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("01/05/1963",'%d/%m/%Y'), as.Date("15/10/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans")+
    theme(axis.line = element_line(color = 'black'),
          axis.text = element_text(size = 6),
          axis.title = element_text(size = 8))
  
  # Inset map
  gage_location <- usmap::us_map(regions = "county", include = 39049)
  inset <- usmap::plot_usmap(regions = "states", color = "#dadedf", size = 0.2)+
    geom_polygon(data = gage_location, aes(x = x, y = y), color = "#e6af84", fill = "#e6af84", size = 0.5)
  
  # Legend
  legend_data <- data.frame(group = rep(c("Average streamflow",
                                          "Daily streamflow", "Severe drought threshold"), each = 6),
                            x = c(1:6, 1:6, 1:6),
                            y = c(11,10,11,10,11,10, 9,8,9,8,9,8, 7,6,7,6,7,6))
  legend <- ggplot(data = legend_data, aes(x = x, y = y, group = group))+
    geom_line(aes(color = group))+
    annotate("rect", xmin = 1, xmax = 6, ymin = 3, ymax = 4.5, fill = "#e6af84", alpha = 0.8)+
    scale_color_manual(values = c("#9bd9f7", "#bf683c", "#5691e2"))+
    theme_void()+
    theme(legend.position = "none")+
    ylim(c(0,11))+
    xlim(c(0,13))+
    annotate("text", label = "Average streamflow", x = 6.5, y = 10.2, hjust = 0, vjust = 0, size = 1.45)+
    annotate("text", label = "Drought threshold", x = 6.5, y = 8.2, hjust = 0, vjust = 0, size = 1.45)+
    annotate("text", label = "Daily streamflow", x = 6.5, y = 6.2, hjust = 0, vjust = 0, size = 1.45)+
    annotate("text", label = "Severe Drought", x = 6.5, y = 3.4, hjust = 0, vjust = 0, size = 1.45)
  
  
  # Background
  color_bknd = "white"
  canvas <- grid::rectGrob(
    x = 0, y = 0, 
    width = 16, height = 9,
    gp = grid::gpar(fill = color_bknd, alpha = 1, col = color_bknd)
  )
  
  # compose final plot
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0, y = 1,
              height = 9, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0.3-0.025,
              y = 0.0,
              height = 0.95,
              width = 0.65) +
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.7,
              height = 0.3,
              width = 0.2) +
    # legend
    draw_plot(legend,
              x = 0.0,
              y = 0.15,
              height = 0.3,
              width = 0.25)+
    # Drippy
    draw_image(image = "3_visualize/in/Drippy100mod.png", 
               x = 0, 
               y = 0.8, 
               width = 0.2, 
               height = 0.2,
               hjust = 0.25, 
               vjust = 0)+
    # Explainer text
    draw_text(text = 'And let our threshold\nchange week to week',
              x = 0.025,
              y = 0.6,
              hjust = 0,
              vjust = 0,
              size = 6)
  
  
  
  # Save and convert file
  ggsave(out_png, width = 1200, height = 600, dpi = 300, units = "px")
  return(out_png)
}

#' @description This function creates the sixth frame for the drought learner viz gif/video
#' @param p2_droughts_learner_viz_df df, the data that contains the drought properties for the focal 
#' period and site
#' @param p2_streamflow_learner_viz_df df, the data that contains the streamflow by date, average 
#' streamflow by day of year, and the thresholds for the focal period and site
#' @param out_png filepath, the output filepath for this viz frame
drought_lrnr_viz07 <- function(p2_droughts_learner_viz_df, p2_streamflow_learner_viz_df, out_png) {
  
  # since the fixed threshold is one static number, create it for a y-intercept and geom_hline
  fixed_threshold <- unique(p2_streamflow_learner_viz_df$thresh_10_site)
  
  
  # Main viz
  main <- ggplot(data = p2_streamflow_learner_viz_df, aes(y = value, x = dt))+
    annotate("rect", # variable threshold
             xmin = (p2_droughts_learner_viz_df$start[p2_droughts_learner_viz_df$method == "variable"]),
             xmax = (p2_droughts_learner_viz_df$end[p2_droughts_learner_viz_df$method == "variable"]),
             ymin = -Inf, ymax = Inf,
             fill = "#e6af84", alpha = 0.8)+
    
    annotate("rect", # fixed threshold
             xmin = (p2_droughts_learner_viz_df$start[p2_droughts_learner_viz_df$method == "fixed"]),
             xmax = (p2_droughts_learner_viz_df$end[p2_droughts_learner_viz_df$method == "fixed"]),
             ymin = -Inf, ymax = Inf,
             fill = "#f0cfb5", alpha = 0.3)+
    
    ylim(c(0,1550))+
    # Streamflow by day mean across all years
    geom_line(data = p2_streamflow_learner_viz_df, aes(y = mean_flow, x = dt), color = "#9bd9f7")+
    
    # Add in thresholds
    geom_hline(yintercept = fixed_threshold, color = "#bf683c", alpha = 0.3)+
    geom_line(aes(y = thresh_10_jd_07d_wndw, x = dt), color = "#c1272d")+
    # Streamflow by day
    geom_line(color = "#5691e2", size = .45)+ 
    ylab("Streamflow (cfs)")+
    xlab("1963")+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("01/05/1963",'%d/%m/%Y'), as.Date("15/10/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans")+
    theme(axis.line = element_line(color = 'black'),
          axis.text = element_text(size = 6),
          axis.title = element_text(size = 8))
  
  # Inset map
  gage_location <- usmap::us_map(regions = "county", include = 39049)
  inset <- usmap::plot_usmap(regions = "states", color = "#dadedf", size = 0.2)+
    geom_polygon(data = gage_location, aes(x = x, y = y), color = "#e6af84", fill = "#e6af84", size = 0.5)
  
  # Legend
  legend_data <- data.frame(group = rep(c("Average streamflow",
                                          "Daily streamflow", "Severe drought threshold"), each = 6),
                            x = c(1:6, 1:6, 1:6),
                            y = c(11,10,11,10,11,10, 9,8,9,8,9,8, 7,6,7,6,7,6))
  legend <- ggplot(data = legend_data, aes(x = x, y = y, group = group))+
    geom_line(aes(color = group))+
    annotate("rect", xmin = 1, xmax = 6, ymin = 3, ymax = 4.5, fill = "#e6af84", alpha = 0.8)+
    scale_color_manual(values = c("#9bd9f7", "#bf683c", "#5691e2"))+
    theme_void()+
    theme(legend.position = "none")+
    ylim(c(0,11))+
    xlim(c(0,13))+
    annotate("text", label = "Average streamflow", x = 6.5, y = 10.2, hjust = 0, vjust = 0, size = 1.45)+
    annotate("text", label = "Drought threshold", x = 6.5, y = 8.2, hjust = 0, vjust = 0, size = 1.45)+
    annotate("text", label = "Daily streamflow", x = 6.5, y = 6.2, hjust = 0, vjust = 0, size = 1.45)+
    annotate("text", label = "Severe Drought", x = 6.5, y = 3.4, hjust = 0, vjust = 0, size = 1.45)
  
  
  # Background
  color_bknd = "white"
  canvas <- grid::rectGrob(
    x = 0, y = 0, 
    width = 16, height = 9,
    gp = grid::gpar(fill = color_bknd, alpha = 1, col = color_bknd)
  )
  
  # compose final plot
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0, y = 1,
              height = 9, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0.3-0.025,
              y = 0.0,
              height = 0.95,
              width = 0.65) +
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.7,
              height = 0.3,
              width = 0.2) +
    # legend
    draw_plot(legend,
              x = 0.0,
              y = 0.15,
              height = 0.3,
              width = 0.25)+
    # Drippy
    draw_image(image = "3_visualize/in/Drippy100mod.png", 
               x = 0, 
               y = 0.8, 
               width = 0.2, 
               height = 0.2,
               hjust = 0.25, 
               vjust = 0)+
    # Explainer text
    draw_text(text = 'This variable threshold\nchanges the timing and\nnumber of droughts',
              x = 0.025,
              y = 0.6,
              hjust = 0,
              vjust = 0,
              size = 6)
  
  
  
  # Save and convert file
  ggsave(out_png, width = 1200, height = 600, dpi = 300, units = "px")
  return(out_png)
}




