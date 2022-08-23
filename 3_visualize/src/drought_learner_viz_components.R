blank_plot <- function(streamflow_df, dv_tibble){
  blank_plot <- ggplot(data = streamflow_df, aes(y = value, x = dt))+
    ylab("Streamflow\n(cfs)")+
    xlab(NULL)+
    scale_y_continuous(limits = c(0,1400), 
                       labels = c(0,400,800,1200),
                       breaks = c(0, 400, 800, 1200))+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("01/05/1963",'%d/%m/%Y'), as.Date("15/10/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans", base_size = 16)+
    theme(#axis.line = element_line(color = dv_tibble$dv_basePlot_axis_color, size = dv_tibble$dv_basePlot_axis_size),
          axis.ticks = element_line(color = dv_tibble$dv_basePlot_axis_color, 
                                    size = dv_tibble$dv_basePlot_axis_size),
          axis.text = element_text(size = 6),
          axis.title = element_text(size = 8),
          panel.background = element_blank())
  
  return(blank_plot)
}


inset_map <- function(){
  # Inset map
  gage_location <- usmap::us_map(regions = "county", include = 39049)
  inset <- usmap::plot_usmap(regions = "states", fill = "#dadedf", size = 0.1, color = "white")+
    geom_polygon(data = gage_location, aes(x = x, y = y), 
                 color = "red", fill = "red", size = 0.5)
  
  return(inset)
  }

background_canvas <- function(){
  # Background
  color_bknd = "transparent"
  canvas <- grid::rectGrob(
    x = 0, y = 0, 
    width = 16, height = 12,
    gp = grid::gpar(fill = color_bknd, alpha = 1, col = color_bknd)
  )
  
}

bottom_bars <- function(both, droughts_df, blank_plot, dv_tibble){
  
  #   # Bottom bars

      if(both == FALSE){
        bottom_bars <- blank_plot +
        annotate("rect", # fixed threshold
               xmin = droughts_df$start[droughts_df$method == "fixed"],
               xmax = droughts_df$end[droughts_df$method == "fixed"],
               ymin = 52, ymax = 100,
               fill = dv_tibble$dv_drought_fill_fixed, alpha = 0.8)+
      theme(axis.title = element_text(color = "transparent"),
            axis.text = element_text(color = "transparent"),
            axis.line = element_line(color = "transparent"),
            axis.ticks = element_line(color = "transparent"))
  } else {
    bottom_bars <- blank_plot +   
    annotate("rect", # fixed threshold
               xmin = (droughts_df$start[droughts_df$method == "fixed"]),
               xmax = (droughts_df$end[droughts_df$method == "fixed"]),
               ymin = 52, ymax = 100,
               fill = dv_tibble$dv_drought_fill_fixed, alpha = 0.8)+
      annotate("rect", # variable threshold
               xmin = (droughts_df$start[droughts_df$method == "variable"]),
               xmax = (droughts_df$end[droughts_df$method == "variable"]),
               ymin = 0, ymax = 48,
               fill = dv_tibble$dv_drought_fill_variable, alpha = 0.8)+
      theme(axis.title = element_text(color = "transparent"),
            axis.text = element_text(color = "transparent"),
            axis.line = element_line(color = "transparent"),
            axis.ticks = element_line(color = "transparent"))
  }
  
  return(bottom_bars)
}


frame_a <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){
  
  main <- blank_plot +
    # Fixed threshold drought durations
    annotate("rect", # fixed threshold
             xmin = droughts_df$start[droughts_df$method == "fixed"],
             xmax = droughts_df$end[droughts_df$method == "fixed"],
             ymin = -Inf, ymax = Inf,
             fill = dv_tibble$dv_drought_fill_fixed, alpha = 0.8) +
    annotate("text", label = "Periods of\nSevere\nDrought", 
             x = as.Date("01/08/1963",'%d/%m/%Y'), hjust = 0.5,
             y = 1000, color = dv_tibble$dv_drought_textColor, size = 2) + 
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = 0.3)+
    annotate("text", label = "Daily\nstreamflow", 
             x = as.Date("03/06/1963",'%d/%m/%Y'), hjust = 0,
             y = 420, color = dv_tibble$dv_streamflow_textcolor_daily, size = 2)
  
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0,
              y = 0.1,
              height = 0.9,
              width = 1)+
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # Bottom bars
    draw_plot(bottom_bars,
              x = 0, 
              y = -0.05,
              height = 0.4,
              width = 1)+
    draw_text("Frame a",
              x = 0.05, 
              y = 0.95,
              size = 4)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}



frame_b <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){

  
  main <- blank_plot +
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = 0.3)+
    annotate("text", label = "Daily\nstreamflow", 
             x = as.Date("03/06/1963",'%d/%m/%Y'), hjust = 0,
             y = 420, color = dv_tibble$dv_streamflow_textcolor_daily, size = 2)+
    # Average daily streamflow
    geom_line(aes(y = mean_flow), color = dv_tibble$dv_streamflow_line_daily_average)+
    annotate("text", label = "Daily average\nstreamflow", 
             x = as.Date("17/07/1963",'%d/%m/%Y'), hjust = 0,
             y = 800, color = dv_tibble$dv_streamflow_textcolor_daily_average, size = 2)
  
  
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0,
              y = 0.1,
              height = 0.9,
              width = 1)+
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # Bottom bars
    draw_plot(bottom_bars,
              x = 0, 
              y = -0.05,
              height = 0.4,
              width = 1)+
    draw_text("Frame b",
              x = 0.05, 
              y = 0.95,
              size = 4)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}


frame_c <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){

  
  main <- blank_plot +
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = 0.3)+
    annotate("text", label = "Daily\nstreamflow", 
             x = as.Date("03/06/1963",'%d/%m/%Y'), hjust = 0,
             y = 420, color = dv_tibble$dv_streamflow_textcolor_daily, size = 2)+
    # Average daily streamflow
    geom_line(aes(y = mean_flow), color = dv_tibble$dv_streamflow_line_daily_average)+
    annotate("text", label = "Daily average\nstreamflow", 
             x = as.Date("17/07/1963",'%d/%m/%Y'), hjust = 0,
             y = 800, color = dv_tibble$dv_streamflow_textcolor_daily_average, size = 2)+
    # Average annual streamflow 
    geom_line(aes(y = mean(mean_flow)), color = dv_tibble$dv_streamflow_line_annual_average)+
    annotate("text", label = "Annual average streamflow", 
             x = as.Date("17/07/1963",'%d/%m/%Y'), hjust = 0,
             y = 970, color = dv_tibble$dv_streamflow_textcolor_annual_average, size = 2)
  
  
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0,
              y = 0.1,
              height = 0.9,
              width = 1)+
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # Bottom bars
    draw_plot(bottom_bars,
              x = 0, 
              y = -0.05,
              height = 0.4,
              width = 1)+
    draw_text("Frame c",
              x = 0.05, 
              y = 0.95,
              size = 4)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}


frame_d <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){

  
  main <- blank_plot +
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = 0.3)+
    annotate("text", label = "Daily\nstreamflow", 
             x = as.Date("03/06/1963",'%d/%m/%Y'), hjust = 0,
             y = 420, color = dv_tibble$dv_streamflow_textcolor_daily, size = 2)+
    # Average daily streamflow
    geom_line(aes(y = mean_flow), color = dv_tibble$dv_streamflow_line_daily_average)+
    annotate("text", label = "Daily average\nstreamflow", 
             x = as.Date("17/07/1963",'%d/%m/%Y'), hjust = 0,
             y = 800, color = dv_tibble$dv_streamflow_textcolor_daily_average, size = 2)+
    # Average daily streamflow across year
    geom_line(aes(y = mean(mean_flow)), color = dv_tibble$dv_streamflow_line_annual_average)+
    annotate("text", label = "Annual average streamflow", 
             x = as.Date("17/07/1963",'%d/%m/%Y'), hjust = 0,
             y = 970, color = dv_tibble$dv_streamflow_textcolor_annual_average, size = 2)+
    # Severe drought threshold (10%)
    geom_line(aes(y = thresh_10_site), color = dv_tibble$dv_drought_threshold_fixed)+
    annotate("text", label = "10% of annual average streamflow", 
             x = as.Date("17/05/1963",'%d/%m/%Y'), hjust = 0,
             y = 15, color = dv_tibble$dv_drought_textColor, size = 2)
  
  
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0,
              y = 0.1,
              height = 0.9,
              width = 1)+
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # Bottom bars
    draw_plot(bottom_bars,
              x = 0, 
              y = -0.05,
              height = 0.4,
              width = 1)+
    draw_text("Frame d",
              x = 0.05, 
              y = 0.95,
              size = 4)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}


frame_e <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){
  

  fill_drought_bottom <- streamflow_df %>%
    filter(dt >= as.Date("15/08/1963",'%d/%m/%Y'), 
           dt <= as.Date("28/08/1963",'%d/%m/%Y')) %>%
    select(dt, value)
  
  fill_drought_top <- fill_drought_bottom %>%
    mutate(value = 45) %>%
    arrange(-yday(dt))
  
  fill_drought <- bind_rows(fill_drought_bottom, fill_drought_top) %>%
    mutate(id = 1)
  
  mask_poly <- data.frame(
    id = rep(1, 8),
    subid = rep(1:2,each = 4),
    x = c(as.Date("01/05/1963",'%d/%m/%Y'), as.Date("01/05/1963",'%d/%m/%Y'), 
          as.Date("15/10/1963",'%d/%m/%Y'), as.Date("15/10/1963",'%d/%m/%Y'),
          as.Date("15/08/1963",'%d/%m/%Y'), as.Date("15/08/1963",'%d/%m/%Y'), 
          as.Date("28/08/1963",'%d/%m/%Y'), as.Date("28/08/1963",'%d/%m/%Y')),
    y = c(-Inf, Inf, Inf, -Inf,
          0, 100, 100, 0)
  )
  
  main <- blank_plot +
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = 0.3)+
    annotate("text", label = "Daily\nstreamflow", 
             x = as.Date("03/06/1963",'%d/%m/%Y'), hjust = 0,
             y = 420, color = dv_tibble$dv_streamflow_textcolor_daily, size = 2)+
    # Average daily streamflow
    geom_line(aes(y = mean_flow), color = dv_tibble$dv_streamflow_line_daily_average)+
    annotate("text", label = "Daily average\nstreamflow", 
             x = as.Date("17/07/1963",'%d/%m/%Y'), hjust = 0,
             y = 800, color = dv_tibble$dv_streamflow_textcolor_daily_average, size = 2)+
    # Average daily streamflow across year
    geom_line(aes(y = mean(mean_flow)), color = dv_tibble$dv_streamflow_line_annual_average)+
    # Severe drought threshold (10%)
    geom_line(aes(y = thresh_10_site), color = dv_tibble$dv_drought_threshold_fixed)+
    annotate("text", label = "10% of annual average streamflow", 
             x = as.Date("17/05/1963",'%d/%m/%Y'), hjust = 0,
             y = 15, color = dv_tibble$dv_drought_textColor, size = 2)+
    # Transparent mask
    geom_polygon(data = mask_poly, 
                 aes(group = id, x = x, y = y, subgroup = subid), 
                 fill = dv_tibble$dv_shading_fill, alpha = 0.8)+
    geom_polygon(data = mask_poly %>% filter(subid == 2), 
                 aes(group = id, x = x, y = y), 
                 color = dv_tibble$dv_zoom_box_outline, fill = "transparent", size = 0.1)+
    annotate("segment", y = 100, yend = 400, 
             x = as.Date("29/08/1963",'%d/%m/%Y'),
             xend = as.Date("26/09/1963",'%d/%m/%Y'),
             color = dv_tibble$dv_zoom_box_lines, size = 0.2)+
    annotate("segment", y = 400, yend = 100, 
             x = as.Date("16/07/1963",'%d/%m/%Y'),
             xend = as.Date("14/08/1963",'%d/%m/%Y'),
             color = dv_tibble$dv_zoom_box_lines, size = 0.2)
  
  # Zoomed in plot
  zoom_plot <- ggplot(data = streamflow_df, aes(y = value, x = dt))+
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = 0.3)+
    annotate("text", label = "Daily\nstreamflow", 
             x = as.Date("03/06/1963",'%d/%m/%Y'), hjust = 0,
             y = 420, color = dv_tibble$dv_streamflow_textcolor_daily, size = 2)+
    # Severe drought threshold (10%)
    geom_line(aes(y = thresh_10_site), color = dv_tibble$dv_drought_threshold_fixed)+
    annotate("text", label = "10% of annual average streamflow", 
             x = as.Date("17/05/1963",'%d/%m/%Y'), hjust = 0,
             y = 15, color = dv_tibble$dv_drought_textColor, size = 2)+
    # Severe drought fill
    geom_polygon(data = fill_drought, aes(group = id, x = dt, y = value), 
                 fill = dv_tibble$dv_drought_fill_fixed, alpha = 0.3)+
    ylab(NULL)+
    xlab(NULL)+
    ylim(c(0,100))+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("13/08/1963",'%d/%m/%Y'), as.Date("30/08/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans", base_size = 16)+
    theme(axis.line = element_line(color = 'black'),
          axis.text = element_text(size = 6),
          axis.title = element_text(size = 8),
          panel.background = element_blank())+
    annotate("text", label = "Daily streamflow", 
             x = as.Date("13/08/1963",'%d/%m/%Y'), hjust = 0,
             y = 86, color = dv_tibble$dv_streamflow_textcolor_daily, size = 2)+
    annotate("text", label = "10% average streamflow", 
             x = as.Date("15/08/1963",'%d/%m/%Y'), hjust = 0,
             y = 52, color = dv_tibble$dv_drought_textColor, size = 2)+
    annotate("text", label = "Severe\nDrought", 
             x = as.Date("23/08/1963",'%d/%m/%Y')+0.5, hjust = 0.5,
             y = 25, color = dv_tibble$dv_drought_textColor, size = 2.2)
  
  
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0,
              y = 0.1,
              height = 0.9,
              width = 1)+
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # Bottom bars
    draw_plot(bottom_bars,
              x = 0, 
              y = -0.05,
              height = 0.4,
              width = 1)+
    # Zoomed in chart
    draw_plot(zoom_plot,
              x = 0.45,
              y = 0.41,
              height = 0.4,
              width = 0.44)+
    draw_text("Frame e",
              x = 0.05, 
              y = 0.95,
              size = 4)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}



frame_f <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){
  
  main <- blank_plot +
    # Fixed threshold drought durations
    annotate("rect", # fixed threshold
             xmin = (droughts_df$start[droughts_df$method == "fixed"]),
             xmax = (droughts_df$end[droughts_df$method == "fixed"]),
             ymin = -Inf, ymax = Inf,
             fill = dv_tibble$dv_drought_fill_fixed, alpha = 0.8) +
    annotate("text", label = "Periods of\nSevere\nDrought", 
             x = as.Date("01/08/1963",'%d/%m/%Y'), hjust = 0.5,
             y = 1000, color = dv_tibble$dv_drought_textColor, size = 2) + 
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = 0.3)+
    # Average daily streamflow
    geom_line(aes(y = mean_flow), color = dv_tibble$dv_streamflow_line_daily_average)+
    # Severe drought threshold (10%)
    geom_line(aes(y = thresh_10_site), color = dv_tibble$dv_drought_threshold_fixed)+
    annotate("text", label = "10% of annual average streamflow", 
             x = as.Date("17/05/1963",'%d/%m/%Y'), hjust = 0,
             y = 15, color = dv_tibble$dv_drought_textColor, size = 2)
  
  
  
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0,
              y = 0.1,
              height = 0.9,
              width = 1)+
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # Bottom bars
    draw_plot(bottom_bars,
              x = 0, 
              y = -0.05,
              height = 0.4,
              width = 1)+
    draw_text("Frame f",
              x = 0.05, 
              y = 0.95,
              size = 4)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}

frame_g <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){

  
  main <- blank_plot +
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = 0.3)+
    annotate("text", label = "Daily\nstreamflow",
             x = as.Date("03/06/1963",'%d/%m/%Y'), hjust = 0,
             y = 420, color = dv_tibble$dv_streamflow_textcolor_daily, size = 2)+
    # Average daily streamflow
    geom_line(aes(y = mean_flow), color = dv_tibble$dv_streamflow_line_daily_average)+
    annotate("text", label = "Daily average\nstreamflow",
             x = as.Date("17/07/1963",'%d/%m/%Y'), hjust = 0,
             y = 800, color = dv_tibble$dv_streamflow_textcolor_daily_average, size = 2)
  
  
  
  
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0,
              y = 0.1,
              height = 0.9,
              width = 1)+
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # Bottom bars
    draw_plot(bottom_bars,
              x = 0, 
              y = -0.05,
              height = 0.4,
              width = 1)+
    draw_text("Frame g",
              x = 0.05, 
              y = 0.95,
              size = 4)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}

frame_h <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){
  main <- blank_plot +
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = 0.3)+
    annotate("text", label = "Daily\nstreamflow",
             x = as.Date("03/06/1963",'%d/%m/%Y'), hjust = 0,
             y = 420, color = dv_tibble$dv_streamflow_textcolor_daily, size = 2)+
    # Average daily streamflow
    geom_line(aes(y = mean_flow), color = dv_tibble$dv_streamflow_line_daily_average)+
    annotate("text", label = "Daily average\nstreamflow",
             x = as.Date("17/07/1963",'%d/%m/%Y'), hjust = 0,
             y = 800, color = dv_tibble$dv_streamflow_textcolor_daily_average, size = 2)+
    # Circle explainer
    annotate("point", x = as.Date("13/05/1963",'%d/%m/%Y'), y = 110,
             size = 3, pch = 1, color = dv_tibble$dv_circle_explainer)+
    annotate("point", x = as.Date("13/05/1963",'%d/%m/%Y'), y = 1210,
             size = 3, pch = 1, color = dv_tibble$dv_circle_explainer)+
    annotate("segment", x = as.Date("13/05/1963",'%d/%m/%Y'),
             xend = as.Date("13/05/1963",'%d/%m/%Y'),
             y = 1100, yend = 200, color = dv_tibble$dv_circle_explainer,
             arrow = arrow(length = unit(0.1, "cm")))+
    annotate("text", label = "Typical streamflow",
             x = as.Date("14/05/1963",'%d/%m/%Y'), y = 1280, hjust = 0,
             color = dv_tibble$dv_circle_explainer, size = 2)+
    annotate("text", label = "Actual streamflow",
             x = as.Date("14/05/1963",'%d/%m/%Y'), y = 30, hjust = 0,
             color = dv_tibble$dv_circle_explainer, size = 2)
  
  
  
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0,
              y = 0.1,
              height = 0.9,
              width = 1)+
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # Bottom bars
    draw_plot(bottom_bars,
              x = 0, 
              y = -0.05,
              height = 0.4,
              width = 1)+
    draw_text("Frame h",
              x = 0.05, 
              y = 0.95,
              size = 4)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}


frame_i <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){

  
  main <- blank_plot +
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = 0.3)+
    annotate("text", label = "Daily\nstreamflow",
             x = as.Date("03/06/1963",'%d/%m/%Y'), hjust = 0,
             y = 420, color = dv_tibble$dv_streamflow_textcolor_daily, size = 2)+
    # Average daily streamflow
    geom_line(aes(y = mean_flow), color = dv_tibble$dv_streamflow_line_daily_average)+
    annotate("text", label = "Daily average\nstreamflow",
             x = as.Date("17/07/1963",'%d/%m/%Y'), hjust = 0,
             y = 800, color = dv_tibble$dv_streamflow_textcolor_daily_average, size = 2)+
    # Variable Threshold
    geom_line(aes(y = thresh_10_jd_07d_wndw, x = dt), color = dv_tibble$dv_drought_threshold_variable)

  
  
  
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0,
              y = 0.1,
              height = 0.9,
              width = 1)+
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # Bottom bars
    draw_plot(bottom_bars,
              x = 0, 
              y = -0.05,
              height = 0.4,
              width = 1)+
    draw_text("Frame i",
              x = 0.05, 
              y = 0.95,
              size = 4)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}

frame_j <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){

  
  main <- blank_plot +
    # Variable threshold drought durations
    annotate("rect", # variable threshold
             xmin = (droughts_df$start[droughts_df$method == "variable"]),
             xmax = (droughts_df$end[droughts_df$method == "variable"]),
             ymin = -Inf, ymax = Inf,
             fill = dv_tibble$dv_drought_fill_variable, alpha = 0.8) +
    annotate("text", label = "Periods of\nSevere\nDrought", 
             x = as.Date("01/08/1963",'%d/%m/%Y'), hjust = 0.5,
             y = 1000, color = dv_tibble$dv_drought_textColor, size = 2)+
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = 0.3)+
    # Average daily streamflow
    geom_line(aes(y = mean_flow), color = dv_tibble$dv_streamflow_line_daily_average)+
    # Variable Threshold
    geom_line(aes(y = thresh_10_jd_07d_wndw, x = dt), color = dv_tibble$dv_drought_threshold_variable)
  
  
 
  
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0,
              y = 0.1,
              height = 0.9,
              width = 1)+
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # Bottom bars
    draw_plot(bottom_bars,
              x = 0, 
              y = -0.05,
              height = 0.4,
              width = 1)+
    draw_text("Frame j",
              x = 0.05, 
              y = 0.95,
              size = 4)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}

frame_k <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){

  
  main <- blank_plot +
    # Fixed threshold drought durations
    annotate("rect", # fixed threshold
             xmin = (droughts_df$start[droughts_df$method == "fixed"]),
             xmax = (droughts_df$end[droughts_df$method == "fixed"]),
             ymin = 650, ymax = Inf,
             fill = dv_tibble$dv_drought_fill_fixed, alpha = 0.8) +
    # Variable threshold drought durations
    annotate("rect", # variable threshold
             xmin = (droughts_df$start[droughts_df$method == "variable"]),
             xmax = (droughts_df$end[droughts_df$method == "variable"]),
             ymin = -Inf, ymax = 600,
             fill = dv_tibble$dv_drought_fill_variable, alpha = 0.8) +
    theme(axis.title.y = element_text(color="transparent"),
          axis.text.y = element_text(color = "transparent"),
          axis.ticks.y = element_line(color = "transparent"))
  
  
  
  
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0,
              y = 0.1,
              height = 0.9,
              width = 1)+
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # Bottom bars
    draw_plot(bottom_bars,
              x = 0, 
              y = -0.05,
              height = 0.4,
              width = 1)+
    draw_text("Frame k",
              x = 0.05, 
              y = 0.95,
              size = 4)+
    # Annotation
    draw_text("Periods of\nSevere\nDrought\nwith a\nFixed\nThreshold", 
             x = 0.1, hjust = 0.5,
             y = 0.75, color = dv_tibble$dv_drought_fill_fixed, size = 5) +
    draw_text("Periods of\nSevere\nDrought\nwith a\nVariable\nThreshold", 
             x = 0.1, hjust = 0.5,
             y = 0.4, color = dv_tibble$dv_drought_fill_variable, size = 5)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}


frame_l <- function(streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){

  
  blank_plot_year <- ggplot(data = streamflow_df, aes(y = value, x = dt))+
    ylab("Streamflow\n(cfs)")+
    xlab(NULL)+
    scale_y_continuous(limits = c(0,1400), 
                       labels = c(0,200,400,600,800,1000,1200,1400),
                       breaks = c(0, 200, 400, 600, 800, 1000, 1200,1400))+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("01/01/1963",'%d/%m/%Y'), as.Date("31/12/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans", base_size = 16)+
    theme(axis.line = element_line(color = 'black'),
          axis.text = element_text(size = 6),
          axis.title = element_text(size = 8),
          panel.background = element_blank())
  
  main <- blank_plot_year +
    # Fixed threshold drought durations
    annotate("rect", # fixed threshold
             xmin = (droughts_df$start[droughts_df$method == "fixed"]),
             xmax = (droughts_df$end[droughts_df$method == "fixed"]),
             ymin = 650, ymax = Inf,
             fill = dv_tibble$dv_drought_fill_fixed, alpha = 0.8) +
    # Variable threshold drought durations
    annotate("rect", # variable threshold
             xmin = (droughts_df$start[droughts_df$method == "variable"]),
             xmax = (droughts_df$end[droughts_df$method == "variable"]),
             ymin = -Inf, ymax = 600,
             fill = dv_tibble$dv_drought_fill_variable, alpha = 0.8) +
    theme(axis.title.y = element_text(color="transparent"),
          axis.text.y = element_text(color = "transparent"),
          axis.ticks.y = element_line(color = "transparent"))

  
  # Bottom bars
  bottom_bars_year <- blank_plot_year + 
    annotate("rect", # fixed threshold
             xmin = (droughts_df$start[droughts_df$method == "fixed"]),
             xmax = (droughts_df$end[droughts_df$method == "fixed"]),
             ymin = 52, ymax = 100,
             fill = dv_tibble$dv_drought_fill_fixed, alpha = 0.8)+
    annotate("rect", # variable threshold
             xmin = (droughts_df$start[droughts_df$method == "variable"]),
             xmax = (droughts_df$end[droughts_df$method == "variable"]),
             ymin = 0, ymax = 48,
             fill = dv_tibble$dv_drought_fill_variable, alpha = 0.8)+
    theme(axis.title = element_text(color = "transparent"),
          axis.text = element_text(color = "transparent"),
          axis.line = element_line(color = "transparent"),
          axis.ticks = element_line(color = "transparent"))
  
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0,
              y = 0.1,
              height = 0.9,
              width = 1)+
    # Inset map
    draw_plot(inset,
              x = 0.8,
              y = 0.8,
              height = 0.2,
              width = 0.2) +
    # Bottom bars
    draw_plot(bottom_bars_year,
              x = 0, 
              y = -0.05,
              height = 0.4,
              width = 1)+
    draw_text("Frame l",
              x = 0.05, 
              y = 0.95,
              size = 4)+
    # Annotation
    draw_text("Periods of\nSevere\nDrought\nwith a\nFixed\nThreshold", 
              x = 0.1, hjust = 0.5,
              y = 0.75, color = dv_tibble$dv_drought_fill_fixed, size = 5) +
    draw_text("Periods of\nSevere\nDrought\nwith a\nVariable\nThreshold", 
              x = 0.1, hjust = 0.5,
              y = 0.4, color = dv_tibble$dv_drought_fill_variable, size = 5)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}

frame_m <- function(streamflow_df, 
                    droughts_df,
                    droughts_70yr_site_df, 
                    droughts_70yr_j7_df, 
                    canvas, 
                    out_png,
                    dv_tibble){

  
  blank_plot_year <- ggplot(data = streamflow_df, aes(y = value, x = dt))+
    ylab("Year\n(sort of)")+
    xlab(NULL)+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("01/01/1963",'%d/%m/%Y'), as.Date("31/12/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans", base_size = 16)+
    theme(axis.line = element_line(color = 'black'),
          axis.text = element_text(size = 6),
          axis.title = element_text(size = 8),
          panel.background = element_blank())
  
  main <- blank_plot_year +
    geom_hline(yintercept = 1949, color = "#666666", size = 0.2, linetype = "dashed")+
    # Fixed threshold drought durations
    annotate("rect", # fixed threshold
             xmin = (droughts_70yr_site_df$start_fakeYr),
             xmax = (droughts_70yr_site_df$end_fakeYr),
             ymin = droughts_70yr_site_df$start_year-1, ymax = droughts_70yr_site_df$start_year,
             fill = dv_tibble$dv_drought_fill_fixed, alpha = 0.9) +
    # Variable threshold drought durations
    annotate("rect", # variable threshold
             xmin = (droughts_70yr_j7_df$start_fakeYr),
             xmax = (droughts_70yr_j7_df$end_fakeYr),
             ymin = droughts_70yr_j7_df$start_year-70, ymax = droughts_70yr_j7_df$start_year-69,
             fill = dv_tibble$dv_drought_fill_variable, alpha = 0.9)+
    theme(axis.title.y = element_text(color="transparent"),
          axis.text.y = element_text(color = "transparent"),
          axis.ticks.y = element_line(color = "transparent"))
  
  
  # Bottom bars
  bottom_bars_year <- ggplot(data = streamflow_df, aes(y = value, x = dt))+
    ylab("Streamflow\n(cfs)")+
    xlab(NULL)+
    annotate("rect", # fixed threshold
             xmin = (droughts_df$start[droughts_df$method == "fixed"]),
             xmax = (droughts_df$end[droughts_df$method == "fixed"]),
             ymin = 52, ymax = 100,
             fill = dv_tibble$dv_drought_fill_fixed, alpha = 0.8)+
    annotate("rect", # variable threshold
             xmin = (droughts_df$start[droughts_df$method == "variable"]),
             xmax = (droughts_df$end[droughts_df$method == "variable"]),
             ymin = 0, ymax = 48,
             fill = dv_tibble$dv_drought_fill_variable, alpha = 0.8)+
    scale_y_continuous(limits = c(0,1400), 
                       labels = c(0,200,400,600,800,1000,1200,1400),
                       breaks = c(0, 200, 400, 600, 800, 1000, 1200,1400))+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date("01/01/1963",'%d/%m/%Y'), as.Date("31/12/1963",'%d/%m/%Y')))+
    theme_tufte(base_family = "sans", base_size = 16)+
    theme(axis.line = element_line(color = "transparent"),
          axis.text = element_text(size = 6, color = "transparent"),
          axis.title = element_text(size = 8, color = "transparent"),
          panel.background = element_blank(),
          axis.ticks = element_line(color = "transparent"))
  
  ggdraw(ylim = c(0,1), 
         xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1) +
    # Main plot
    draw_plot(main,
              x = 0,
              y = 0.1,
              height = 0.9,
              width = 1)+
    # Bottom bars
    draw_plot(bottom_bars_year,
              x = 0, 
              y = -0.05,
              height = 0.4,
              width = 1)+
    draw_text("Frame m",
              x = 0.05, 
              y = 0.95,
              size = 4)+
    # Annotate years 
    draw_text("1950", size = 4, y = 0.25, x = 0.148, color = "#666666")+
    draw_text("2020", size = 4, y = 0.5765, x = 0.148, color = "#666666")+
    draw_text("1950", size = 4, y = 0.6005, x = 0.148, color = "#666666")+
    draw_text("2020", size = 4, y = 0.92, x = 0.148, color = "#666666")+
    # Annotation
    draw_text("Periods of\nSevere\nDrought\nwith a\nFixed\nThreshold", 
              x = 0.1, hjust = 0.5,
              y = 0.75, color = dv_tibble$dv_drought_fill_fixed, size = 5) +
    draw_text("Periods of\nSevere\nDrought\nwith a\nVariable\nThreshold", 
              x = 0.1, hjust = 0.5,
              y = 0.4, color = dv_tibble$dv_drought_fill_variable, size = 5)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}

