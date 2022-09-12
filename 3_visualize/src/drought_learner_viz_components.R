blank_plot <- function(streamflow_df, dv_tibble, growing_season = T){
  
  axis_rects <- data.frame(
    ymax = rep(-70, 6),
    ymin = rep(-100, 6),
    xmin = c(as.Date(sprintf("01/05/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("01/06/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("01/07/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("01/08/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("01/09/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("01/10/%s", focal_year),'%d/%m/%Y')),
    xmax = c(as.Date(sprintf("31/05/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("30/06/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("31/07/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("31/08/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("30/09/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("14/10/%s", focal_year),'%d/%m/%Y'))
  )
  axis_rects_year <- data.frame(
    ymax = rep(-70, 12),
    ymin = rep(-100, 12),
    xmin = c(as.Date(sprintf("01/01/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("01/02/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("01/03/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("01/04/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("01/05/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("01/06/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("01/07/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("01/08/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("01/09/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("01/10/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("01/11/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("01/12/%s", focal_year),'%d/%m/%Y')),
    xmax = c(as.Date(sprintf("31/01/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("28/02/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("31/03/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("30/04/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("31/05/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("30/06/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("31/07/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("31/08/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("30/09/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("31/10/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("30/11/%s", focal_year),'%d/%m/%Y'),
             as.Date(sprintf("31/12/%s", focal_year),'%d/%m/%Y'))
  )
  
  
  blank_plot <- ggplot(data = streamflow_df, aes(y = value, x = dt))+
    # Axis bars
    ylab("Streamflow\n(cfs)")+
    xlab(NULL)+
    scale_y_continuous(limits = c(-100, 800), 
                       labels = c(0, 800),
                       breaks = c(0, 800))+
    theme_tufte(base_family = "sans", base_size = 16)+
    theme(axis.ticks = element_blank(),
          axis.text = element_text(size = 6,
                                   color = dv_tibble$dv_basePlot_axis_text_color),
          axis.text.x = element_text(vjust = 10),
          axis.text.y = element_blank(),
          axis.title = element_blank(),
          panel.background = element_blank())
  
  
    {if(growing_season == TRUE){
      blank_plot <- blank_plot + 
        scale_x_date(labels = date_format("%b"), 
                   date_breaks  ="1 month",
                   limits = c(as.Date(sprintf("01/05/%s", focal_year),'%d/%m/%Y'), 
                              as.Date(sprintf("15/10/%s", focal_year),'%d/%m/%Y')))+
        annotate("rect", 
                 xmin = axis_rects$xmin,
                 xmax = axis_rects$xmax,
                 ymin = axis_rects$ymin, ymax = axis_rects$ymax,
                 fill = dv_tibble$dv_basePlot_axis_fill_color, alpha = 1.0,
                 color = dv_tibble$df_fill_outline, size = dv_tibble$dv_fill_outline_size) 
    } else {
      blank_plot <- blank_plot + 
        scale_x_date(labels = date_format("%b"), 
                   date_breaks  ="1 month",
                   limits = c(as.Date(sprintf("01/01/%s", focal_year),'%d/%m/%Y'), 
                              as.Date(sprintf("31/12/%s", focal_year),'%d/%m/%Y')))+
        annotate("rect", 
                 xmin = axis_rects_year$xmin,
                 xmax = axis_rects_year$xmax,
                 ymin = axis_rects_year$ymin, ymax = axis_rects_year$ymax,
                 fill = dv_tibble$dv_basePlot_axis_fill_color, alpha = 1.0,
                 color = dv_tibble$df_fill_outline, size = dv_tibble$dv_fill_outline_size) 
    }}
  
  
  
  return(blank_plot)
}


inset_map <- function(state_fill,
                      border_size,
                      border_color,
                      highlight_site_color,
                      view){
  
  
  # Inset map
  gage_location <- ggplot2::map_data('county') %>%
    filter(region == 'ohio',
           subregion == 'franklin')
  
  if(view == "CONUS"){
    state <- ggplot2::map_data('state')
  } else if(view == "midwest"){
    state <- ggplot2::map_data('state') %>%
      filter(region %in% c("wisconsin", "michigan", "ohio", 
                           "indiana", "illinois", 
                           "kentucky"))
  }


  
  inset <-  
    ggplot(data = state, aes(x = long, y = lat, group = group)) + 
      geom_polygon(fill = state_fill,
                   color = border_color,
                   size = border_size) +       
      geom_polygon(data = gage_location, aes(x = long, y = lat, group = group), 
                   color = highlight_site_color, 
                   fill = highlight_site_color, size = 0.5)+
      coord_fixed(1.3) +
      theme_void()
  
  return(inset)
}



bottom_bars <- function(extent = "fixed one", droughts_df, blank_plot, dv_tibble){
  
  #   # Bottom bars
  
  if(extent == "fixed one"){
    bottom_bars <- blank_plot +
      annotate("rect", # fixed threshold
               xmin = droughts_df$start[droughts_df$method == "fixed" & droughts_df$drought_id == 76],
               xmax = droughts_df$end[droughts_df$method == "fixed" & droughts_df$drought_id == 76],
               ymin = 52, ymax = 100,
               fill = dv_tibble$dv_drought_fill_fixed, alpha = 1.0)+
      theme(axis.title = element_text(color = "transparent"),
            axis.text = element_text(color = "transparent"),
            axis.line = element_line(color = "transparent"),
            axis.ticks = element_line(color = "transparent"))
  } else if(extent == "fixed all"){
    bottom_bars <- blank_plot +
      annotate("rect", # fixed threshold
               xmin = droughts_df$start[droughts_df$method == "fixed"],
               xmax = droughts_df$end[droughts_df$method == "fixed"],
               ymin = 52, ymax = 100,
               fill = dv_tibble$dv_drought_fill_fixed, alpha = 1.0)+
      theme(axis.title = element_text(color = "transparent"),
            axis.text = element_text(color = "transparent"),
            axis.line = element_line(color = "transparent"),
            axis.ticks = element_line(color = "transparent"))
  } else if(extent == "both") {
    bottom_bars <- blank_plot +   
      annotate("rect", # fixed threshold
               xmin = (droughts_df$start[droughts_df$method == "fixed"]),
               xmax = (droughts_df$end[droughts_df$method == "fixed"]),
               ymin = 52, ymax = 100,
               fill = dv_tibble$dv_drought_fill_fixed, alpha = 1.0)+
      annotate("rect", # variable threshold
               xmin = (droughts_df$start[droughts_df$method == "variable"]),
               xmax = (droughts_df$end[droughts_df$method == "variable"]),
               ymin = 0, ymax = 48,
               fill = dv_tibble$dv_drought_fill_variable, alpha = 1.0)+
      theme(axis.title = element_text(color = "transparent"),
            axis.text = element_text(color = "transparent"),
            axis.line = element_line(color = "transparent"),
            axis.ticks = element_line(color = "transparent"))
  } else if(extent == "both year"){
    bottom_bars <- blank_plot + 
      annotate("rect", # fixed threshold
               xmin = (droughts_df$start[droughts_df$method == "fixed"]),
               xmax = (droughts_df$end[droughts_df$method == "fixed"]),
               ymin = 52, ymax = 100,
               fill = dv_tibble$dv_drought_fill_fixed, alpha = 1.0)+
      annotate("rect", # variable threshold
               xmin = (droughts_df$start[droughts_df$method == "variable"]),
               xmax = (droughts_df$end[droughts_df$method == "variable"]),
               ymin = 0, ymax = 48,
               fill = dv_tibble$dv_drought_fill_variable, alpha = 1.0)+
      theme(axis.title = element_text(color = "transparent"),
            axis.text = element_text(color = "transparent"),
            axis.line = element_line(color = "transparent"),
            axis.ticks = element_line(color = "transparent"))+
      scale_x_date(labels = date_format("%b"),
                   date_breaks = "1 month",
                   limits = c(as.Date(sprintf("01/01/%s", focal_year), '%d/%m/%Y'),
                              as.Date(sprintf("31/12/%s", focal_year), '%d/%m/%Y')))
  } 
  
  return(bottom_bars)
}

add_core_plot_elements <- function(text, ...) {
  
  
  # Background
  color_bknd = "transparent"
  canvas <- grid::rectGrob(
    x = 0, y = 0, 
    width = 16, height = 12,
    gp = grid::gpar(fill = color_bknd, alpha = 1, col = color_bknd)
  )
  
  # pull out passed elements into list
  elements <- list(...)
  
  # set positioning for each element
  element_positioning <- tibble(
    element = c('main', 'inset', 'bottom_bars'),
    x = c(0, 0.8, 0),
    y = c(0.1, 0.8, -0.05),
    height = c(1, 0.2, 0.4),
    width = c(1, 0.2, 1)
  )
  
  # start plot with canvas
  plot <- ggdraw(ylim = c(0,1), 
                 xlim = c(0,1)) +
    # fill in the background
    draw_grob(canvas,
              x = 0.25, y = 1,
              height = 12, width = 16,
              hjust = 0, vjust = 1)
  
  # add each of the passed elements
  for (element in names(elements)) {
    element_position <- filter(element_positioning, element==!!element)
    plot <- plot + draw_plot(elements[[element]], 
                             x= element_position$x, 
                             y= element_position$y, 
                             height= element_position$height,
                             width = element_position$width)
  }
  
  # add text w/ frame name
  plot +
    draw_text(text,
              x = 0.05, 
              y = 0.95,
              size = 4)
  
  
}











frame_a <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){
  

  
  main <- blank_plot +
    # Fixed threshold drought durations
    annotate("rect", # fixed threshold
             xmin = droughts_df$start[droughts_df$method == "fixed" & droughts_df$drought_id == 76],
             xmax = droughts_df$end[droughts_df$method == "fixed" & droughts_df$drought_id == 76],
             ymin = -100, ymax = -70,
             fill = dv_tibble$dv_drought_fill_fixed, alpha = 1.0,
             color = dv_tibble$df_fill_outline, size = dv_tibble$dv_fill_outline_size) +
    annotate("rect", # fixed threshold
             xmin = droughts_df$start[droughts_df$method == "fixed" & droughts_df$drought_id == 76],
             xmax = droughts_df$end[droughts_df$method == "fixed" & droughts_df$drought_id == 76],
             ymin = -30, ymax = 700,
             fill = dv_tibble$dv_drought_fill_fixed,
             color = dv_tibble$df_fill_outline, size = dv_tibble$dv_fill_outline_size) +
    annotate("text", label = "Period of\ndrought", 
             x = as.Date(sprintf("20/07/%s", focal_year),'%d/%m/%Y'), hjust = 0.5,
             y = 1200, color = dv_tibble$dv_drought_textColor, size = 2) + 
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = dv_tibble$dv_streamflow_line_size)+
    annotate("text", label = "Daily\nstreamflow", 
             x = as.Date(sprintf("05/06/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 580, color = dv_tibble$dv_streamflow_textcolor_daily, size = 2)+
    theme(axis.text.x = element_text(size = 4))+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date(sprintf("01/05/%s", focal_year),'%d/%m/%Y'), 
                            as.Date(sprintf("15/10/%s", focal_year),'%d/%m/%Y')))
  
  inset_zoom <- inset +
    xlim(c(0,2516293)) +
    ylim(c(-1250000,731650))
  
  
  circle <- grid::circleGrob(gp = grid::gpar(color = dv_tibble$dv_zoom_box_outline))
  
  plot <- add_core_plot_elements(text = 'frame a')
  
  plot +
    draw_plot(inset,
              x = -0.1,
              y = 0.2,
              width = 0.6,
              height = 0.7)+
    draw_plot(main,
              x = 0.4,
              y = 0.1,
              width = 0.6,
              height = 0.5)+
    draw_grob(circle, scale = 0.15, y = -0.24, x = 0.31)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}




frame_b <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){
  
  
  fill_drought_bottom <- streamflow_df %>%
    filter(dt >= as.Date(sprintf("15/08/%s", focal_year),'%d/%m/%Y'), 
           dt <= as.Date(sprintf("28/08/%s", focal_year),'%d/%m/%Y')) %>%
    select(dt, value)
  
  fill_drought_top <- fill_drought_bottom %>%
    mutate(value = 45) %>%
    arrange(-yday(dt))
  
  fill_drought <- bind_rows(fill_drought_bottom, fill_drought_top) %>%
    mutate(id = 1)
  
  mask_poly <- data.frame(
    id = rep(1, 8),
    subid = rep(1:2,each = 4),
    x = c(as.Date(sprintf("01/05/%s", focal_year),'%d/%m/%Y'), 
          as.Date(sprintf("01/05/%s", focal_year),'%d/%m/%Y'), 
          as.Date(sprintf("15/10/%s", focal_year),'%d/%m/%Y'), 
          as.Date(sprintf("15/10/%s", focal_year),'%d/%m/%Y'),
          as.Date(sprintf("15/08/%s", focal_year),'%d/%m/%Y'), 
          as.Date(sprintf("15/08/%s", focal_year),'%d/%m/%Y'), 
          as.Date(sprintf("28/08/%s", focal_year),'%d/%m/%Y'), 
          as.Date(sprintf("28/08/%s", focal_year),'%d/%m/%Y')),
    y = c(-Inf, Inf, Inf, -Inf,
          0, 100, 100, 0)
  )
  
  main <- blank_plot +
    # Fixed threshold drought durations
    annotate("rect", # fixed threshold
             xmin = droughts_df$start[droughts_df$method == "fixed" & droughts_df$drought_id == 76],
             xmax = droughts_df$end[droughts_df$method == "fixed" & droughts_df$drought_id == 76],
             ymin = -100, ymax = -70,
             fill = dv_tibble$dv_drought_fill_fixed, alpha = 1.0,
             color = dv_tibble$df_fill_outline, size = dv_tibble$dv_fill_outline_size) +
    annotate("rect", # fixed threshold
             xmin = droughts_df$start[droughts_df$method == "fixed" & droughts_df$drought_id == 76],
             xmax = droughts_df$end[droughts_df$method == "fixed" & droughts_df$drought_id == 76],
             ymin = -30, ymax = 700,
             fill = dv_tibble$dv_drought_fill_fixed, 
             color = dv_tibble$df_fill_outline, size = dv_tibble$dv_fill_outline_size) +
    annotate("text", label = "Period of\ndrought", 
             x = as.Date(sprintf("20/07/%s", focal_year),'%d/%m/%Y'), hjust = 0.5,
             y = 1200, color = dv_tibble$dv_drought_textColor, size = 2) + 
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = dv_tibble$dv_streamflow_line_size)+
    annotate("text", label = "Daily\nstreamflow", 
             x = as.Date(sprintf("05/06/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 580, color = dv_tibble$dv_streamflow_textcolor_daily, size = 2)+
    theme(axis.text.x = element_text(size = 4))
  
  # Zoomed in plot
  zoom_plot <- ggplot(data = streamflow_df, aes(y = value, x = dt))+
    geom_polygon(data = fill_drought, aes(group = id, x = dt, y = value),
                 fill = dv_tibble$dv_drought_fill_fixed)+
    geom_line(color = dv_tibble$dv_streamflow_line_daily, 
              size = dv_tibble$dv_streamflow_line_size)+
    geom_line(aes(y = thresh_10_site), 
              color = dv_tibble$dv_drought_threshold_fixed, 
              size = dv_tibble$dv_threshold_line_size)+
    ylab(NULL)+
    xlab(NULL)+
    ylim(c(0,100))+
    scale_x_date(labels = date_format("%b"), 
                 date_breaks  ="1 month",
                 limits = c(as.Date(sprintf("10/08/%s", focal_year),'%d/%m/%Y'), 
                            as.Date(sprintf("02/09/%s", focal_year),'%d/%m/%Y')))+
    theme_tufte(base_family = "sans", base_size = 16)+
    theme(axis.line = element_line(color = "transparent"),
          axis.text = element_blank(),
          axis.title = element_text(size = 5,
                                    color = dv_tibble$dv_basePlot_axis_color),
          panel.background = element_blank(),
          axis.ticks = element_blank())+
    annotate("text", label = "Daily\n  streamflow", 
             x = as.Date(sprintf("13/08/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 86, color = dv_tibble$dv_streamflow_textcolor_daily, size = 2)+
    annotate("text", label = "Drought threshold", 
             x = as.Date(sprintf("15/08/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 52, color = dv_tibble$dv_drought_textColor, size = 1.8)+
    annotate("text", label = "Drought", 
             x = as.Date(sprintf("23/08/%s", focal_year),'%d/%m/%Y')+0.5, hjust = 0.5,
             y = 25, color = dv_tibble$dv_streamflow_textcolor_daily, size = 1.8)
  
  circle <- grid::circleGrob(gp = grid::gpar(color = dv_tibble$dv_zoom_box_outline))
  
  plot <- add_core_plot_elements(text = 'frame b')
  
  plot +
    draw_plot(inset,
              x = -0.1,
              y = 0.2,
              width = 0.6,
              height = 0.7)+
    draw_plot(main,
              x = 0.4,
              y = 0.1,
              width = 0.6,
              height = 0.5)+
    draw_plot(zoom_plot,
              x = 0.63,
              y = 0.5, 
              height = 0.4,
              width = 0.35)+
    draw_grob(circle, scale = 0.15, y = -0.24, x = 0.31)+
    draw_grob(circle, scale = 0.42, y = 0.24, x = 0.31)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}


frame_c <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){
  
  
  main <- blank_plot +
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = dv_tibble$dv_streamflow_line_size)+
    annotate("text", label = "Daily\nstreamflow", 
             x = as.Date(sprintf("03/06/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 420, color = dv_tibble$dv_streamflow_textcolor_daily, size = 2)
    
  
  
  add_core_plot_elements(text = 'frame c', 
                         main = main, inset = inset)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}


frame_d <-  function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){
  
  
  main <- blank_plot +
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = dv_tibble$dv_streamflow_line_size)+
    annotate("text", label = "Daily\nstreamflow", 
             x = as.Date(sprintf("03/06/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 420, color = dv_tibble$dv_streamflow_textcolor_daily, size = 2)+
    # Severe drought threshold (10%)
    geom_line(aes(y = thresh_10_site), color = dv_tibble$dv_drought_threshold_fixed, 
              size = dv_tibble$dv_threshold_line_size)+
    annotate("text", label = "10% of annual average streamflow", 
             x = as.Date(sprintf("17/05/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 15, color = dv_tibble$dv_drought_textColor, size = 2)
  
  
  add_core_plot_elements(text = 'frame d', 
                         main = main, inset = inset)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}




frame_e <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){
  
  main <- blank_plot +
    # Fixed threshold drought durations
    annotate("rect", # fixed threshold
             xmin = droughts_df$start[droughts_df$method == "fixed"],
             xmax = droughts_df$end[droughts_df$method == "fixed"],
             ymin = -100, ymax = -70,
             fill = dv_tibble$dv_drought_fill_fixed, alpha = 1.0,
             color = dv_tibble$df_fill_outline, size = dv_tibble$dv_fill_outline_size) +
    annotate("rect", # fixed threshold
             xmin = droughts_df$start[droughts_df$method == "fixed"],
             xmax = droughts_df$end[droughts_df$method == "fixed"],
             ymin = -30, ymax = 700,
             fill = dv_tibble$dv_drought_fill_fixed, alpha = 0.5,
             color = dv_tibble$df_fill_outline, size = dv_tibble$dv_fill_outline_size) +
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = dv_tibble$dv_streamflow_line_size)+
    annotate("text", label = "Daily\nstreamflow", 
             x = as.Date(sprintf("03/06/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 420, color = dv_tibble$dv_streamflow_textcolor_daily, size = 2)+
    # Severe drought threshold (10%)
    geom_line(aes(y = thresh_10_site), color = dv_tibble$dv_drought_threshold_fixed, 
              size = dv_tibble$dv_threshold_line_size)+
    annotate("text", label = "10% of annual average streamflow", 
             x = as.Date(sprintf("17/05/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 15, color = dv_tibble$dv_drought_textColor, size = 2)+
    
    
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = dv_tibble$dv_streamflow_line_size-0.1)
  
  
  
  add_core_plot_elements(text = 'frame e', 
                         main = main, inset = inset)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}

frame_f <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){
  
  
  main <- blank_plot +
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = dv_tibble$dv_streamflow_line_size)+
    annotate("text", label = "Daily\nstreamflow",
             x = as.Date(sprintf("03/06/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 420, color = dv_tibble$dv_streamflow_fade, size = 2)+
    # Average daily streamflow
    geom_line(aes(y = mean_flow), color = dv_tibble$dv_streamflow_line_daily_average, 
              size = dv_tibble$dv_streamflow_line_size)+
    annotate("text", label = "Average daily\nstreamflow\n(1951-2020)",
             x = as.Date(sprintf("17/07/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 800, color = dv_tibble$dv_streamflow_textcolor_daily_average, size = 2)+
    ylim(c(-100,1400))
  
  
  
  
  add_core_plot_elements(text = 'frame f', 
                         main = main, inset = inset)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}

frame_g <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){
  main <- blank_plot +
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_fade, size = dv_tibble$dv_streamflow_line_size)+
    annotate("text", label = "Daily\nstreamflow",
             x = as.Date(sprintf("03/06/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 420, color = dv_tibble$dv_streamflow_fade, size = 2)+
    # Average daily streamflow
    geom_line(aes(y = mean_flow), color = dv_tibble$dv_streamflow_fade,
              size = dv_tibble$dv_streamflow_line_size)+
    annotate("text", label = "Average daily\nstreamflow\n(1951-2020)",
             x = as.Date(sprintf("17/07/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 800, color = dv_tibble$dv_streamflow_fade, size = 2)+
    # Circle explainer
    annotate("point", x = as.Date(sprintf("13/05/%s", focal_year),'%d/%m/%Y'), y = 110,
             size = 3, pch = 1, color = dv_tibble$dv_circle_explainer)+
    annotate("point", x = as.Date(sprintf("13/05/%s", focal_year),'%d/%m/%Y'), y = 1210,
             size = 3, pch = 1, color = dv_tibble$dv_circle_explainer)+
    annotate("segment", x = as.Date(sprintf("13/05/%s", focal_year),'%d/%m/%Y'),
             xend = as.Date(sprintf("13/05/%s", focal_year),'%d/%m/%Y'),
             y = 1100, yend = 200, color = dv_tibble$dv_circle_explainer,
             arrow = arrow(length = unit(0.1, "cm")))+
    annotate("text", label = "Typical daily streamflow",
             x = as.Date(sprintf("14/05/%s", focal_year),'%d/%m/%Y'), y = 1280, hjust = 0,
             color = dv_tibble$dv_circle_explainer, size = 2)+
    annotate("text", label = "Actual daily streamflow",
             x = as.Date(sprintf("14/05/%s", focal_year),'%d/%m/%Y'), y = 10, hjust = 0,
             color = dv_tibble$dv_circle_explainer, size = 2)+
    ylim(c(-100,1400))
  
  
  
  add_core_plot_elements(text = 'frame g', 
                         main = main, inset = inset)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}


frame_h <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){
  
  
  main <- blank_plot +
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_fade, size = dv_tibble$dv_streamflow_line_size)+
    annotate("text", label = "Daily\nstreamflow",
             x = as.Date(sprintf("03/06/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 420, color = dv_tibble$dv_streamflow_fade, size = 2)+
    # Average daily streamflow
    geom_line(aes(y = mean_flow), color = dv_tibble$dv_streamflow_fade,
              size = dv_tibble$dv_streamflow_line_size)+
    annotate("text", label = "Average daily\nstreamflow\n(1951-2020)",
             x = as.Date(sprintf("17/07/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 800, color = dv_tibble$dv_streamflow_fade, size = 2)+
    # Variable Threshold
    geom_line(aes(y = thresh_10_jd_07d_wndw, x = dt), color = dv_tibble$dv_drought_threshold_variable, 
              size = dv_tibble$dv_threshold_line_size)+
    annotate("text", label = "10% of average daily streamflow", 
             x = as.Date(sprintf("17/05/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 15, color = dv_tibble$dv_drought_threshold_variable, size = 2)+
    ylim(c(-100,1400))
  
  
  
  add_core_plot_elements(text = 'frame h', 
                         main = main, inset = inset)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}

frame_i <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){
  
  
  main <- blank_plot +
    # Variable threshold drought durations
    annotate("rect", # fixed threshold
             xmin = droughts_df$start[droughts_df$method == "variable"],
             xmax = droughts_df$end[droughts_df$method == "variable"],
             ymin = -100, ymax = -70,
             fill = dv_tibble$dv_drought_fill_fixed, alpha = 1.0,
             color = dv_tibble$df_fill_outline, size = dv_tibble$dv_fill_outline_size) +
    annotate("rect", # fixed threshold
             xmin = droughts_df$start[droughts_df$method == "variable"],
             xmax = droughts_df$end[droughts_df$method == "variable"],
             ymin = -30, ymax = 700,
             fill = dv_tibble$dv_drought_fill_fixed, alpha = 0.5,
             color = dv_tibble$df_fill_outline, size = dv_tibble$dv_fill_outline_size) +
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = dv_tibble$dv_streamflow_line_size)+
    # Variable Threshold
    geom_line(aes(y = thresh_10_jd_07d_wndw, x = dt), color = dv_tibble$dv_drought_threshold_variable, 
              size = dv_tibble$dv_threshold_line_size)+
    
    # This site's 1963 streamflow
    geom_line(color = dv_tibble$dv_streamflow_line_daily, size = dv_tibble$dv_streamflow_line_size-0.1)
  
  
  
  add_core_plot_elements(text = 'frame i', 
                         main = main, inset = inset)
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}

frame_j <- function(blank_plot, streamflow_df, droughts_df,
                    bottom_bars, canvas, inset, out_png, dv_tibble){
  

  
  main <- blank_plot +
    # Fixed threshold drought durations
    annotate("rect", # fixed threshold
             xmin = (droughts_df$start[droughts_df$method == "fixed"]),
             xmax = (droughts_df$end[droughts_df$method == "fixed"]),
             ymin = 310, ymax = 590,
             fill = dv_tibble$dv_drought_fill_fixed, 
             color = dv_tibble$df_fill_outline, size = dv_tibble$dv_fill_outline_size) +
    # Variable threshold drought durations
    annotate("rect", # variable threshold
             xmin = (droughts_df$start[droughts_df$method == "variable"]),
             xmax = (droughts_df$end[droughts_df$method == "variable"]),
             ymin = -30, ymax = 250,
             fill = dv_tibble$dv_drought_fill_variable, 
             color = dv_tibble$df_fill_outline, size = dv_tibble$dv_fill_outline_size) +
    annotate("text", label = "Periods of Drought with a Variable Threshold", 
              x = as.Date(sprintf("01/05/%s", focal_year),'%d/%m/%Y'), hjust = 0,
              y = 280, color = dv_tibble$dv_drought_textColor, size = 2) +
    annotate("text", label = "Periods of Drought with a Fixed Threshold", 
              x = as.Date(sprintf("01/05/%s", focal_year),'%d/%m/%Y'), hjust = 0,
              y = 620, color = dv_tibble$dv_drought_textColor, size = 2)
  
  
  
  plot <- add_core_plot_elements(text = 'frame j', 
                                 main = main, inset = inset)
  


  
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
             ymin = 310, ymax = 590,
             fill = dv_tibble$dv_drought_fill_fixed, 
             color = dv_tibble$df_fill_outline, size = dv_tibble$dv_fill_outline_size) +
    # Variable threshold drought durations
    annotate("rect", # variable threshold
             xmin = (droughts_df$start[droughts_df$method == "variable"]),
             xmax = (droughts_df$end[droughts_df$method == "variable"]),
             ymin = -30, ymax = 250,
             fill = dv_tibble$dv_drought_fill_variable, 
             color = dv_tibble$df_fill_outline, size = dv_tibble$dv_fill_outline_size) +
    annotate("text", label = "Periods of Drought with a Variable Threshold", 
             x = as.Date(sprintf("01/01/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 280, color = dv_tibble$dv_drought_textColor, size = 2) +
    annotate("text", label = "Periods of Drought with a Fixed Threshold", 
             x = as.Date(sprintf("01/01/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 620, color = dv_tibble$dv_drought_textColor, size = 2)  
  
  

  
  plot <- add_core_plot_elements(text = 'frame k', 
                                 main = main, inset = inset)
  
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}

frame_l <- function(blank_plot, 
                    streamflow_df, 
                    droughts_df,
                    droughts_70yr_site_df, 
                    droughts_70yr_j7_df, 
                    bottom_bars,
                    canvas, 
                    out_png,
                    dv_tibble){
  
  
  baseline_fixed <- 310
  baseline_variable <- -30
  origin <- 1950
  
  main <- blank_plot +
    # Fixed threshold drought durations
    annotate("rect", # fixed threshold
             xmin = (droughts_70yr_site_df$start_fakeYr),
             xmax = (droughts_70yr_site_df$end_fakeYr),
             ymin = ((droughts_70yr_site_df$start_year-origin)*4)+baseline_fixed, 
             ymax = ((droughts_70yr_site_df$start_year-origin)*4)+baseline_fixed +1,
             fill = dv_tibble$dv_drought_fill_fixed) +
    # Variable threshold drought durations
    annotate("rect", # variable threshold
             xmin = (droughts_70yr_j7_df$start_fakeYr),
             xmax = (droughts_70yr_j7_df$end_fakeYr),
             ymin = ((droughts_70yr_j7_df$start_year-origin)*4)+baseline_variable, 
             ymax = ((droughts_70yr_j7_df$start_year-origin)*4)+baseline_variable + 1,
             fill = dv_tibble$dv_drought_fill_variable)+
    annotate("text", label = "Periods of Drought with a Variable Threshold", 
             x = as.Date(sprintf("01/01/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 280, color = dv_tibble$dv_drought_textColor, size = 2) +
    annotate("text", label = "Periods of Drought with a Fixed Threshold", 
             x = as.Date(sprintf("01/01/%s", focal_year),'%d/%m/%Y'), hjust = 0,
             y = 620, color = dv_tibble$dv_drought_textColor, size = 2) +
    annotate("text", label = c("1950", "2020", "1950", "2020"), 
             x = rep(as.Date(sprintf("01/01/%s", focal_year),'%d/%m/%Y'),4),
             y = c(baseline_variable, baseline_variable + 280,
                   baseline_fixed, baseline_fixed + 280),
             color = dv_tibble$dv_drought_textColor,
             size = 1, hjust =1.1) 
  

  
  plot <- add_core_plot_elements(text = 'frame l', 
                                 main = main)
  
  
  
  ggsave(out_png, width = dv_tibble$dv_png_width, 
         height = dv_tibble$dv_png_height, dpi = 300, units = "px")
}


