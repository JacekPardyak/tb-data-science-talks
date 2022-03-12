# Geospatial data available at the geojson format
library(geojsonio)
spdf <- geojson_read("https://raw.githubusercontent.com/gregoiredavid/france-geojson/master/communes.geojson",  what = "sp")

# Since it is a bit too much data, I select only a subset of it:
spdf <- spdf[ substr(spdf@data$code,1,2)  %in% c("06", "83", "13", "30", "34", "11", "66") , ]

spdf

library(broom)
spdf_fortified <- tidy(spdf, region = "code")

# Now I can plot this shape easily as described before:
library(ggplot2)
ggplot() +
  geom_polygon(data = spdf_fortified, aes( x = long, y = lat, group = group), fill="white", color="grey") +
  theme_void() +
  coord_map()

# read data
data <- read.table("https://raw.githubusercontent.com/holtzy/R-graph-gallery/master/DATA/data_on_french_states.csv", header=T, sep=";")
head(data)

# Distribution of the number of restaurant?
library(dplyr)
data %>%
  ggplot( aes(x=nb_equip)) +
  geom_histogram(bins=20, fill='skyblue', color='#69b3a2') + scale_x_log10()

# Make the merge
spdf_fortified = spdf_fortified %>%
  left_join(. , data, by=c("id"="depcom"))

# Note that if the number of restaurant is NA, it is in fact 0
spdf_fortified$nb_equip[ is.na(spdf_fortified$nb_equip)] = 0.001

ggplot() +
  geom_polygon(data = spdf_fortified, aes(fill = nb_equip, x = long, y = lat, group = group)) +
  theme_void() +
  coord_map()

library(viridis)
p <- ggplot() +
  geom_polygon(data = spdf_fortified, aes(fill = nb_equip, x = long, y = lat, group = group) , size=0, alpha=0.9) +
  theme_void() +
  scale_fill_viridis(trans = "log", breaks=c(1,5,10,20,50,100), name="Number of restaurant", guide = guide_legend( keyheight = unit(3, units = "mm"), keywidth=unit(12, units = "mm"), label.position = "bottom", title.position = 'top', nrow=1) ) +
  labs(
    title = "South of France Restaurant concentration",
    subtitle = "Number of restaurant per city district",
    caption = "Data: INSEE | Creation: Yan Holtz | r-graph-gallery.com"
  ) +
  theme(
    text = element_text(color = "#22211d"),
    plot.background = element_rect(fill = "#f5f5f2", color = NA),
    panel.background = element_rect(fill = "#f5f5f2", color = NA),
    legend.background = element_rect(fill = "#f5f5f2", color = NA),
    
    plot.title = element_text(size= 22, hjust=0.01, color = "#4e4d47", margin = margin(b = -0.1, t = 0.4, l = 2, unit = "cm")),
    plot.subtitle = element_text(size= 17, hjust=0.01, color = "#4e4d47", margin = margin(b = -0.1, t = 0.43, l = 2, unit = "cm")),
    plot.caption = element_text( size=12, color = "#4e4d47", margin = margin(b = 0.3, r=-99, unit = "cm") ),
    
    legend.position = c(0.7, 0.09)
  ) +
  coord_map()
p


# fake animatin
spdf_fortified_2017 <- spdf_fortified %>% mutate(year = 2017)
spdf_fortified_2018 <- spdf_fortified %>% mutate(year = 2018) %>%
  mutate(nb_equip = sample(nb_equip))

spdf_fortified_df <- spdf_fortified_2017 %>% 
  bind_rows(spdf_fortified_2018)

library(gganimate)
ggplot() +
  geom_polygon(data = spdf_fortified_df, 
               aes(fill = nb_equip, x = long, y = lat, group = group)) +
  theme_void() +
  coord_map() +
  labs(title = "Date: {frame_time}", size = "Users") +
  transition_time(year) 
  
  