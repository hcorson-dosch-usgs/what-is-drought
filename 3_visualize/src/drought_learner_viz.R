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
    xlab(NULL)+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("01/05/1963",'%d/%m/%Y'), as.Date("15/10/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans", base_size = 16)+
    theme(axis.line = element_line(color = 'black'),
          axis.text = element_text(size = 6),
          axis.title = element_text(size = 8),
          panel.background = element_blank())
  
  # Inset map
  gage_location <- usmap::us_map(regions = "county", include = 39049)
  inset <- usmap::plot_usmap(regions = "states", fill = "#dadedf", size = 0.1, color = "white")+
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
  color_bknd = "transparent"
  canvas <- grid::rectGrob(
    x = 0, y = 0, 
    width = 16, height = 12,
    gp = grid::gpar(fill = color_bknd, alpha = 1, col = color_bknd)
  )
  
  # compose final plot
  ggdraw(ylim = c(0,1), 
         xlim = c(0.25,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0.25,
              y = 0.25,
              height = 0.75,
              width = 0.75) +
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # legend
    draw_plot(legend,
              x = 0.35,
              y = 0.05,
              height = 0.2,
              width = 0.25)+
    # Drippy
    draw_image(image = "3_visualize/in/drippy_woohoo-01.png", 
               x = 0.65, 
               y = 0.05, 
               width = 0.2, 
               height = 0.2,
               hjust = 0.25, 
               vjust = 0)
  
  
  # Save and convert file
  ggsave(out_png, width = 1200, height = 800, dpi = 300, units = "px")
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
    xlab(NULL)+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("01/05/1963",'%d/%m/%Y'), as.Date("15/10/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans", base_size = 16)+
    theme(axis.line = element_line(color = 'black'),
          axis.text = element_text(size = 6),
          axis.title = element_text(size = 8),
          panel.background = element_blank())
  
  # Inset map
  gage_location <- usmap::us_map(regions = "county", include = 39049)
  inset <- usmap::plot_usmap(regions = "states", fill = "#dadedf", size = 0.1, color = "white")+
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
  color_bknd = "transparent"
  canvas <- grid::rectGrob(
    x = 0, y = 0, 
    width = 16, height = 12,
    gp = grid::gpar(fill = color_bknd, alpha = 1, col = color_bknd)
  )
  
  # compose final plot
  ggdraw(ylim = c(0,1), 
         xlim = c(0.25,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0.25,
              y = 0.25,
              height = 0.75,
              width = 0.75) +
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # legend
    draw_plot(legend,
              x = 0.35,
              y = 0.05,
              height = 0.2,
              width = 0.25)+
    # Drippy
    draw_image(image = "3_visualize/in/drippy_woohoo-01.png", 
               x = 0.65, 
               y = 0.05, 
               width = 0.2, 
               height = 0.2,
               hjust = 0.25, 
               vjust = 0)
  
  # Save and convert file
  ggsave(out_png, width = 1200, height = 800, dpi = 300, units = "px")
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
    xlab(NULL)+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("01/05/1963",'%d/%m/%Y'), as.Date("15/10/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans", base_size = 16)+
    theme(axis.line = element_line(color = 'black'),
          axis.text = element_text(size = 6),
          axis.title = element_text(size = 8),
          panel.background = element_blank())
  
  # Inset map
  gage_location <- usmap::us_map(regions = "county", include = 39049)
  inset <- usmap::plot_usmap(regions = "states", fill = "#dadedf", size = 0.1, color = "white")+
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
  color_bknd = "transparent"
  canvas <- grid::rectGrob(
    x = 0, y = 0, 
    width = 16, height = 12,
    gp = grid::gpar(fill = color_bknd, alpha = 1, col = color_bknd)
  )
  
  # compose final plot
  ggdraw(ylim = c(0,1), 
         xlim = c(0.25,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0.25,
              y = 0.25,
              height = 0.75,
              width = 0.75) +
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # legend
    draw_plot(legend,
              x = 0.35,
              y = 0.05,
              height = 0.2,
              width = 0.25)+
    # Drippy
    draw_image(image = "3_visualize/in/drippy_woohoo-01.png", 
               x = 0.65, 
               y = 0.05, 
               width = 0.2, 
               height = 0.2,
               hjust = 0.25, 
               vjust = 0)
  
  # Save and convert file
  ggsave(out_png, width = 1200, height = 800, dpi = 300, units = "px")
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
    xlab(NULL)+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("01/05/1963",'%d/%m/%Y'), as.Date("15/10/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans", base_size = 16)+
    theme(axis.line = element_line(color = 'black'),
          axis.text = element_text(size = 6),
          axis.title = element_text(size = 8),
          panel.background = element_blank())
  
  # Inset map
  gage_location <- usmap::us_map(regions = "county", include = 39049)
  inset <- usmap::plot_usmap(regions = "states", fill = "#dadedf", size = 0.1, color = "white")+
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
  color_bknd = "transparent"
  canvas <- grid::rectGrob(
    x = 0, y = 0, 
    width = 16, height = 12,
    gp = grid::gpar(fill = color_bknd, alpha = 1, col = color_bknd)
  )
  
  # compose final plot
  ggdraw(ylim = c(0,1), 
         xlim = c(0.25,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0.25,
              y = 0.25,
              height = 0.75,
              width = 0.75) +
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # legend
    draw_plot(legend,
              x = 0.35,
              y = 0.05,
              height = 0.2,
              width = 0.25)+
    # Drippy
    draw_image(image = "3_visualize/in/drippy_woohoo-01.png", 
               x = 0.65, 
               y = 0.05, 
               width = 0.2, 
               height = 0.2,
               hjust = 0.25, 
               vjust = 0)
  
  # Save and convert file
  ggsave(out_png, width = 1200, height = 800, dpi = 300, units = "px")
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
    xlab(NULL)+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("01/05/1963",'%d/%m/%Y'), as.Date("15/10/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans", base_size = 16)+
    theme(axis.line = element_line(color = 'black'),
          axis.text = element_text(size = 6),
          axis.title = element_text(size = 8),
          panel.background = element_blank())
  
  # Inset map
  gage_location <- usmap::us_map(regions = "county", include = 39049)
  inset <- usmap::plot_usmap(regions = "states", fill = "#dadedf", size = 0.1, color = "white")+
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
  color_bknd = "transparent"
  canvas <- grid::rectGrob(
    x = 0, y = 0, 
    width = 16, height = 12,
    gp = grid::gpar(fill = color_bknd, alpha = 1, col = color_bknd)
  )
  
  # compose final plot
  ggdraw(ylim = c(0,1), 
         xlim = c(0.25,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0.25,
              y = 0.25,
              height = 0.75,
              width = 0.75) +
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # legend
    draw_plot(legend,
              x = 0.35,
              y = 0.05,
              height = 0.2,
              width = 0.25)+
    # Drippy
    draw_image(image = "3_visualize/in/drippy_woohoo-01.png", 
               x = 0.65, 
               y = 0.05,  
               width = 0.2, 
               height = 0.2,
               hjust = 0.25, 
               vjust = 0)
  
  # Save and convert file
  ggsave(out_png, width = 1200, height = 800, dpi = 300, units = "px")
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
    xlab(NULL)+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("01/05/1963",'%d/%m/%Y'), as.Date("15/10/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans", base_size = 16)+
    theme(axis.line = element_line(color = 'black'),
          axis.text = element_text(size = 6),
          axis.title = element_text(size = 8),
          panel.background = element_blank())
  
  # Inset map
  gage_location <- usmap::us_map(regions = "county", include = 39049)
  inset <- usmap::plot_usmap(regions = "states", fill = "#dadedf", size = 0.1, color = "white")+
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
  color_bknd = "transparent"
  canvas <- grid::rectGrob(
    x = 0, y = 0, 
    width = 16, height = 12,
    gp = grid::gpar(fill = color_bknd, alpha = 1, col = color_bknd)
  )
  
  # compose final plot
  ggdraw(ylim = c(0,1), 
         xlim = c(0.25,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0.25,
              y = 0.25,
              height = 0.75,
              width = 0.75) +
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # legend
    draw_plot(legend,
              x = 0.35,
              y = 0.05,
              height = 0.2,
              width = 0.25)+
    # Drippy
    draw_image(image = "3_visualize/in/drippy_woohoo-01.png", 
               x = 0.65, 
               y = 0.05,  
               width = 0.2, 
               height = 0.2,
               hjust = 0.25, 
               vjust = 0)

  
  # Save and convert file
  ggsave(out_png, width = 1200, height = 800, dpi = 300, units = "px")
  return(out_png)
}

#' @description This function creates the seventh frame for the drought learner viz gif/video
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
    xlab(NULL)+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("01/05/1963",'%d/%m/%Y'), as.Date("15/10/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans", base_size = 16)+
    theme(axis.line = element_line(color = 'black'),
          axis.text = element_text(size = 6),
          axis.title = element_text(size = 8),
          panel.background = element_blank())
  
  # Inset map
  gage_location <- usmap::us_map(regions = "county", include = 39049)
  inset <- usmap::plot_usmap(regions = "states", fill = "#dadedf", size = 0.1, color = "white")+
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
  color_bknd = "transparent"
  canvas <- grid::rectGrob(
    x = 0, y = 0, 
    width = 16, height = 12,
    gp = grid::gpar(fill = color_bknd, alpha = 1, col = color_bknd)
  )
  
  # compose final plot
  ggdraw(ylim = c(0,1), 
         xlim = c(0.25,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 9, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0.25,
              y = 0.25,
              height = 0.75,
              width = 0.75) +
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # legend
    draw_plot(legend,
              x = 0.35,
              y = 0.05,
              height = 0.2,
              width = 0.25)+
    # Drippy
    draw_image(image = "3_visualize/in/drippy_woohoo-01.png", 
               x = 0.65, 
               y = 0.05,  
               width = 0.2, 
               height = 0.2,
               hjust = 0.25, 
               vjust = 0)
  
  # Save and convert file
  ggsave(out_png, width = 1200, height = 800, dpi = 300, units = "px")
  return(out_png)
}


#' @description This function creates the eighth frame for the drought learner viz gif/video
#' @param p2_droughts_70year_learner_viz_df df, the data used to create beeswarm
#' @param out_png filepath, the output filepath for this viz frame
drought_lrnr_viz08 <- function(p2_droughts_70year_learner_viz_df, out_png) {
  
  
  # Fixed threshold viz
  fixed_plot <- ggplot(data = p2_droughts_70year_learner_viz_df %>% filter(method == "Fixed"), 
                       aes(x = drought_date_fakeYr, y = y_seq, color = factor(decade)))+
    geom_beeswarm(size = 0.3)+
    coord_polar()+
    ylim(-5,25)+
    xlab("Day of year")+
    ylab("Number of events")+
    scale_x_date(labels = date_format("%b"), breaks = "1 month",
                 limits = c(as.Date("1999-01-01"), as.Date("1999-12-31")))+
    scale_color_scico_d(palette = 'lajolla', direction = -1, begin = 0.1, end = 1)+
    theme_minimal()+
    theme(axis.title = element_blank(),
          axis.text.y = element_blank(),
          axis.text.x = element_text(size = 6, hjust = 0),
          panel.grid.major.y = element_blank(),
          panel.grid.minor.x = element_blank(),
          legend.title = element_blank(),
          legend.text = element_text(size = 5),
          legend.key.size = unit(0.35, 'cm'),
          panel.background = element_blank())
  
  # Fixed threshold viz
  variable_plot <- ggplot(data = p2_droughts_70year_learner_viz_df %>% filter(method == "Variable"), 
                       aes(x = drought_date_fakeYr, y = y_seq, color = decade))+
    geom_beeswarm(size = 0.3)+
    coord_polar()+
    ylim(-5,25)+
    xlab("Day of year")+
    ylab("Number of events")+
    scale_x_date(labels = date_format("%b"), breaks = "1 month",
                 limits = c(as.Date("1999-01-01"), as.Date("1999-12-31")))+
    scale_color_scico(palette = 'lajolla', direction = -1, begin = 0.1, end = 1)+
    theme_minimal()+
    theme(axis.title = element_blank(),
          axis.text.y = element_blank(),
          axis.text.x = element_text(size = 6),
          panel.grid.major.y = element_blank(),
          panel.grid.minor.x = element_blank(),
          legend.title = element_blank(),
          legend.text = element_text(size = 6),
          panel.background = element_blank())
  
  # Inset map
  gage_location <- usmap::us_map(regions = "county", include = 39049)
  inset <- usmap::plot_usmap(regions = "states", fill = "#dadedf", size = 0.1, color = "white")+
    geom_polygon(data = gage_location, aes(x = x, y = y), color = "#e6af84", fill = "#e6af84", size = 0.5)
  
  # Legend
  legend <- get_legend(fixed_plot+
                         guides(color=guide_legend(direction='horizontal',
                                                   label.position = "bottom",
                                                   nrow = 1)))
  
  
  # Background
  color_bknd = "transparent"
  canvas <- grid::rectGrob(
    x = 0, y = 0, 
    width = 16, height = 12,
    gp = grid::gpar(fill = color_bknd, alpha = 1, col = color_bknd)
  )
  
  # compose final plot
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0, y = 1,
              height = 10, width = 16,
              hjust = 0, vjust = 1) +
    # Fixed plot
    draw_plot(fixed_plot + theme(legend.position = "none"),
              x = -0.25,
              y = 0.25,
              height = 0.75) +
    # Variable plot
    draw_plot(variable_plot + theme(legend.position = "none"),
              x = 0.25,
              y = 0.25,
              height = 0.75)+
    # legend
    draw_plot(legend,
              x = 0.2, 
              y = 0.1,
              height = 0.05, 
              width = 0.5) +
    # labels for threshold types
    draw_text("Fixed", 
              x = 0.2, 
              y = 0.22,
              size = 8,
              vjust = 0,
              hjust = 0)+
    draw_text("Variable", 
              x = 0.66, 
              y = 0.22,
              size = 8,
              vjust = 0,
              hjust = 0)
  
  # Save and convert file
  ggsave(out_png, width = 1200, height = 800, dpi = 300, units = "px")
  return(out_png)
}

