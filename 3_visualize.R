source('3_visualize/src/plot_stripswarm.R')

p3_targets <- list(
  # Recreate shamshaw's strip swarm chart, but with more sites
  tar_target(
    p3_swarm_1980_2020,
    event_swarm_plot(swarm_data = p2_site_swarm)
  ),
  tar_target(upper_crb_jd_5_1980_2021_png,
             ggsave('3_visualize/out/swarm_test.png', 
                    p3_swarm_1980_2020,
                    width = 14, height = 10, dpi = 300),
             format = "file" )
)