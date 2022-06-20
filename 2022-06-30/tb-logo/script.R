library(tidyverse)
library(sf)
library(plotly)

logo <- st_read("./2022-06-30/tb-logo/logo.dxf") %>% select(geometry) %>% mutate(nrow = 1:n())
logo %>% plot_ly(text = ~nrow, hoverinfo = "text")

# (t)eam.blue
l1 <- logo %>% slice(1:44) %>% 
  select(geometry) %>% st_union() %>% st_polygonize() %>% 
  first() %>% 
  first() %>% st_sfc() %>% st_sf(geometry = .)
l1
l1 %>% ggplot() +
  geom_sf()

# team.bl(u)e
l2 <- logo %>% slice(45:92) %>% 
  select(geometry) %>% st_union() %>% st_polygonize() %>% 
  first() %>% 
  first() %>% st_sfc()  %>% st_sf(geometry = .)
l2
l2 %>% ggplot() +
  geom_sf()

# team.b(l)ue
l3 <- logo %>% slice(93:104) %>% 
  select(geometry) %>% st_union() %>% st_polygonize() %>% 
  first() %>% 
  first() %>% st_sfc()  %>% st_sf(geometry = .)
l3
l3 %>% ggplot() +
  geom_sf()

# t(e)am.blue
l4 <- logo %>% slice(105:179) %>% 
  select(geometry) %>% st_union() %>% st_polygonize() %>% 
  first() %>% 
  first() %>% st_sfc()  %>% st_sf(geometry = .)

p1 <- logo %>% slice(180) %>% select(geometry) %>% 
  first() %>% 
  first() %>% as.matrix()
p2 <- logo %>% slice(195) %>% select(geometry) %>% 
  first() %>% 
  first() %>% as.matrix()

tmp <- p1[1,] %>% rbind(p2[2,]) %>% st_linestring() %>% st_sfc() %>% st_sf(geometry = .)

tmp <- logo %>% slice(180:195) %>% bind_rows(tmp) %>%
    select(geometry) %>% st_union() %>% st_polygonize() %>% 
    first() %>% 
    first() %>% st_sfc()  %>% st_sf(geometry = .)
  
l4 <- l4 %>% st_difference(tmp)
  
l4 %>% ggplot() +
    geom_sf()  

# team.blu(e)
l5 <- logo %>% slice(196:270) %>% 
  select(geometry) %>% st_union() %>% st_polygonize() %>% 
  first() %>% 
  first() %>% st_sfc()  %>% st_sf(geometry = .)
l5 %>% ggplot() +
  geom_sf()

p1 <- logo %>% slice(271) %>% select(geometry) %>% 
  first() %>% 
  first() %>% as.matrix()
p2 <- logo %>% slice(286) %>% select(geometry) %>% 
  first() %>% 
  first() %>% as.matrix()

tmp <- p1[1,] %>% rbind(p2[2,]) %>% st_linestring() %>% st_sfc()  %>% st_sf(geometry = .)
tmp <- logo %>% slice(271:286) %>% bind_rows(tmp) %>%
  select(geometry) %>% st_union() %>% st_polygonize() %>% 
  first() %>% 
  first() %>% st_sfc()  %>% st_sf(geometry = .)

l5 <- l5 %>% st_difference(tmp)

l5 %>% ggplot() +
  geom_sf()

# tea(m).blue
l6 <- logo %>% slice(287:379) %>% 
  select(geometry) %>% st_union() %>% st_polygonize() %>% 
  first() %>% 
  first() %>% st_sfc()  %>% st_sf(geometry = .)
l6
l6 %>% ggplot() +
  geom_sf()

# team(.)blue
l7 <- logo %>% slice(380:412) %>% 
  select(geometry) %>% st_union() %>% st_polygonize() %>% 
  first() %>% 
  first() %>% st_sfc()  %>% st_sf(geometry = .)
l7
l7 %>% ggplot() +
  geom_sf()

# te(a)m.blue
l8 <- logo %>% slice(413:474) %>% 
  select(geometry) %>% st_union() %>% st_polygonize() %>% 
  first() %>% 
  first() %>% st_sfc()  %>% st_sf(geometry = .)
l8 %>% ggplot() +
  geom_sf()

tmp <- logo %>% slice(475:507) %>% 
  select(geometry) %>% st_union() %>% st_polygonize() %>% 
  first() %>% 
  first() %>% st_sfc()  %>% st_sf(geometry = .)

l8 <- l8 %>% st_difference(tmp)
l8 %>% ggplot() +
  geom_sf()

# team.(b)lue
l9 <- logo %>% slice(508:564) %>% 
  select(geometry) %>% st_union() %>% st_polygonize() %>% 
  first() %>% 
  first() %>% st_sfc()  %>% st_sf(geometry = .)

tmp <- logo %>% slice(565:597) %>% 
  select(geometry) %>% st_union() %>% st_polygonize() %>% 
  first() %>% 
  first() %>% st_sfc()  %>% st_sf(geometry = .)
l9 <- l9 %>% st_difference(tmp)

l9 %>% ggplot() +
    geom_sf()
  
# write shape
data <- l1 %>% 
  bind_rows(l4) %>% 
  bind_rows(l8) %>%
  bind_rows(l6) %>%
  bind_rows(l7) %>%
  bind_rows(l9) %>%
  bind_rows(l3) %>%
  bind_rows(l2) %>%
  bind_rows(l5)

st_write(data, "./2022-06-30/tb-logo/logo.shp", append=FALSE)
files = paste("./2022-06-30/tb-logo/logo", c('shp', 'shx', 'dbf'), sep = ".")

tar('./2022-06-30/tb-logo/logo.gz', files = files)
unlink(files)

untar('./2022-06-30/tb-logo/logo.gz')
st_read("./2022-06-30/tb-logo/logo.shp") %>%
  ggplot() +
  geom_sf()

