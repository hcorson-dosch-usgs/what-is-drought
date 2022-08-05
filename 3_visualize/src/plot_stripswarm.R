
event_swarm_plot <- function(swarm_data){
  
  max_dur <- max(swarm_data$duration)
  max_rnum <- max(swarm_data$rnum)
  
  hbreaks <- BAMMtools::getJenksBreaks(swarm_data$duration, k=10)
  scaledBreaks <- scales::rescale(c(0,hbreaks), c(0,1))
  
  # add font
  font_fam <- 'Noto Sans Display'
  font_add_google(font_fam, regular.wt = 300, bold.wt = 700) 
  showtext_opts(dpi = 300)
  showtext_auto(enable = TRUE)
  
  p <- swarm_data %>% ggplot()+
    geom_hline(yintercept=0, color="#dddddd",size = 1)+
    geom_tile(aes(x=date, y=rnum, fill = duration), height=0.5)+
    scale_fill_scico(values = scaledBreaks, palette = "lajolla", begin = 0.25, end = 1 , direction = 1,
                     guide_legend(title = "Drought Duration (Days)"), breaks = c(5, 100, 200, 300))+
    theme_minimal()+
    ylab(element_blank())+
    xlab(element_blank())+
    scale_x_date(breaks = scales::date_breaks(width = '5 years'),
                 labels = scales::label_date_short())+
    theme(axis.text.y=element_blank(),
          axis.text.x=element_text(size = 14, family = font_fam, hjust = 0),
          panel.grid = element_blank(),
          axis.line.x = element_line(color = "black"),
          legend.justification = "center",
          legend.direction = "horizontal",
          panel.spacing.y=unit(0, "lines"))+
    guides(fill = guide_colorbar(
      barheight = 0.62,
      barwidth = 21,
      title.position = "top",
      title.theme = element_text(vjust = 1, size = 16, family = font_fam),
      label.theme=element_text(family = font_fam)
    ))
  
  # piece together plot elements
  p_legend <- get_legend(p) # the legned
  
  ggdraw(xlim = c(0, 1), ylim = c(0, 1)) +
    draw_plot(p+theme(legend.position = "none"), 
              y = 0.1, x = 0, 
              height = 0.8,
              width = 0.95) +
    draw_plot(p_legend, x = 0.06, y = 0.73, width = 0.2, height = 0.1, hjust = 0) 
  
}
