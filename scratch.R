library(secret);library(dplyr)
source("0_config/src/authentication_helpers.R")
set_up_auth("cnell@usgs.gov")


library(targets)
library(tidyverse)
tar_make()

#devtools::install_github("kevinsblake/NatParksPalettes")
library(NatParksPalettes)

# longest droughts

## working on a national scale strip-swarm a la chart challenge

# what data??
tar_load(p2_1951_2020_drought_prop_site)
p2_site = p2_1951_2020_drought_prop_site
p2_site
unique(p2_site$threshold)

tar_load(p2_1951_2020_drought_prop_jd)
p2_1951_2020_drought_prop_jd

tar_load(p2_1951_2020_drought_prop_jd_7d)
p2_1951_2020_drought_prop_jd_7d

tar_load(p2_1951_2020_drought_prop_jd_30d)
p2_1951_2020_drought_prop_jd_30d

## add site locations
tar_load(p2_site_prop_2)
p2_site_prop_2 %>% str
length(unique(p2_site_prop_2$StaID)) # 1912


p2_site <- p2_site_prop_2 %>%
  mutate(year = lubridate::year(start),
         yday_start = lubridate::yday(start),
         yday_end = lubridate::yday(end),
         days = ifelse(yday_end-yday_start < 0, 0, yday_end-yday_start),
         days_yr = ifelse(days == 0, 365-yday_start, days),
         #yday_date = lubridate::day(yday_start)
         ) %>%
  select(contains('days_'), contains('yday_'),everything())
p2_site

## heatmap
p2_site %>%
  ggplot(aes(yday_start, year)) +
  geom_tile(aes(
    fill = mean_intensity,
    #alpha = max_intensity,
    width = days,
    #alpha = severity
    #fill = severity
    ), 
    height = 0.9,
    width = 1,
    alpha = 0.25,
    #color = 'white'
    )+
  theme_void()+
  theme(legend.position = 'top',
        axis.text = element_text(color = 'black', face = "bold")) +
  scale_x_continuous(expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0),
                     breaks =scales::breaks_width(1)) +
  guides(fill = guide_colorbar(
    barwidth = 20,
    barheigh = 1,
    title.position = 'top',
    title.hjust = 0,
    legend.box.just = "left",
    title.theme = element_text(face = 'bold')
  )) +
  scale_alpha(range = c(0.1, 1))+
  scico::scale_fill_scico(palette = 'lajolla', end = 1, begin = 0.25)

## bivariate scale with severity and intensity
p2_site %>% 
  ggplot(aes(year, duration)) +
  geom_point(aes(color = mean_intensity), position = 'jitter', shape = 21)+
  theme_classic(base_size = 14)+
  theme(legend.position = 'top',
        text = element_text(color = 'black', face = "bold", size = 18)) +
  scale_x_continuous(expand = c(0,0)) +
  scale_y_continuous(expand = c(0,0)) +
  guides(color = guide_colorbar(
    barwidth = 20,
    barheigh = 1,
    title.position = 'top',
    title.hjust = 0,
    title.theme = element_text(face = 'bold', size = 18)
  )) +
  scico::scale_color_scico(palette = 'lajolla', end = 1, begin = 0)

## questions - all or less than the threshold??
# what is flow defeciet
# intensity, duration, severity - could swap around
# gages in each threshold cat?
# gages in simultaneus drought out of total
# a giant heatmap
# pecentile lines
# daily values - avg w.e
# wikipulse
# 
tar_load(p2_site_swarm)
swarm_data = p2_site_swarm

combined_swarms <- swarm_data %>%
  mutate(year = lubridate::year(date)) %>%
  mutate(date_order = as.numeric(date-as.Date('1950-01-01')),
         date_start = lubridate::yday(date))
combined_swarms %>% str
## add first date for each year label positioning
x_df <- combined_swarms %>% 
  distinct(year) %>% 
  mutate(date_start = as.Date(sprintf('%s-01-01', year))) %>% 
  mutate(date_order = as.numeric(date_start-as.Date('1950-01-01'))) 
hbreaks <- BAMMtools::getJenksBreaks(swarm_data$duration, k=10)
scaledBreaks <- scales::rescale(c(0,hbreaks), c(0,1))

combined_swarms %>%
  ggplot(aes(x = date_start, y = rnum))+
  geom_hline(yintercept = 0, color="#dddddd",size = 1, linetype = 'dotted')+
  geom_tile(aes(fill = duration), 
            width = 0.9
  )+
  scico::scale_fill_scico(values = scaledBreaks, 
                   palette = "lajolla", 
                   begin = 0.25, 
                   end = 1 , 
                   direction = 1, 
                   guide_legend(title = "Drought duration (days)"),
                   breaks = c(5, 100, 200, 300, 400, 500)) +
  theme_minimal(base_size = 16)+
  ylab(element_blank()) +
  xlab(element_blank()) +
  facet_grid(year~.)+
  theme(text = element_text(),
       axis.text=element_blank(),
       panel.grid = element_blank(),
       panel.spacing.y = unit(0, 'lines'),
       axis.line = element_blank(),
       axis.ticks = element_blank(),
       legend.box.just = "left",
       legend.direction = "horizontal",
       legend.position = 'none') +
  guides(fill = guide_colorbar(
    barheight = 0.62,
    barwidth = 21,
    title.position = "top",
    title.theme = element_text(vjust = 1, size = 16)
  ))#+
  # custom x-axis labelling
  geom_text(data = x_df %>%
              filter(year %in% seq(1950, 2020, by = 1)),
            aes(x=-65, label = year),
            color = "black",
            size = 6,
            fontface="bold") +
  # vertical gridlines for x axis
  geom_segment(data = x_df %>%
                 filter(year %in% seq(1950, 2020, by = 1)),
               aes(x=-60, xend = -2, yend=date_order),
               color = "grey",
               linetype = "dotted")
  )) 
  
  
##
## whaht is the distribution of drought length?
