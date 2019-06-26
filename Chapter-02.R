# Geocomputation with R
# Chapter 2

# LOAD LIBRARIES -------------------------

library(sf)          # classes and functions for vector data
library(raster)      # classes and functions for raster data
library(spData)      # load geographic data
library(spDataLarge) # load larger geographic data

# EXPLORE VECTOR DATA --------------------

# AN INTRODUCTION TO SIMPLE FEATURES
vignette(package="sf") # see which vignettes are available
vignette("sf1")          # an introduction to the package

names(world)
plot(world)
summary(world["lifeExp"])
world_mini <- world[1:2, 1:3]
world_mini

# WHY SIMPLE FEATURES?
# Conversion of objects between sf and sp packages
library(sp)
world_sp <- as(world, Class="Spatial")
world_sf <- st_as_sf(world_sp)

# BASIC MAPMAKING
spplot(world_sp)  # plotting with sp package 
plot(world_sf)    # plotting with sf package
plot(world[3:6])
plot(world["pop"])

world_asia <- world[world$continent == "Asia", ]
asia <- st_union(world_asia)
plot(world["pop"], reset=FALSE)
plot(asia, add=TRUE, col="red")

# BASE PLOT ARGUMENTS
plot(world["continent"], reset=FALSE)
cex = sqrt(world$pop) / 10000
world_cents <- st_centroid(world, of_largest=TRUE)
plot(st_geometry(world_cents), add=TRUE, cex=cex)

india <- world[world$name_long == "India", ]
plot(st_geometry(india), expandBB = c(0, 0.2, 0.1, 1), col = "gray", lwd = 3)
plot(world_asia[0], add = TRUE)

# SIMPLE FEATURE GEOMETRIES
## points
st_point(c(5, 2))                 # XY point
st_point(c(5, 2, 3))              # XYZ point
st_point(c(5, 2, 1), dim="XYM")   # XYM point
st_point(c(5, 2, 3, 1))           # XYZM point

# the rbind function simplifies the creation of matrices
## multipoint
multipoint_matrix <- rbind(c(5, 2), c(1, 3), c(3, 4), c(3, 2))
st_multipoint(multipoint_matrix)

## linestring
linestring_matrix <- rbind(c(1, 5), c(4, 4), c(4, 1), c(2, 2), c(3, 2))
st_linestring(linestring_matrix)

## polygon
polygon_list <- list(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5)))
st_polygon(polygon_list)

## polygon with a hole
polygon_border <- rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5))
polygon_hole <- rbind(c(2, 4), c(3, 4), c(3, 3), c(2, 3), c(2, 4))
polygon_with_hole_list <- list(polygon_border, polygon_hole)
st_polygon(polygon_with_hole_list)

## multilinestring
multilinestring_list <- list(rbind(c(1, 5), c(4, 4), c(4, 1), c(2, 2), c(3, 2)), 
                            rbind(c(1, 2), c(2, 4)))
st_multilinestring((multilinestring_list))

## multipolygon
multipolygon_list <- list(list(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5))),
                         list(rbind(c(0, 2), c(1, 2), c(1, 3), c(0, 3), c(0, 2))))
st_multipolygon(multipolygon_list)

## geometrycollection
gemetrycollection_list <- list(st_multipoint(multipoint_matrix),st_linestring(linestring_matrix))
st_geometrycollection(gemetrycollection_list)

# SIMPLE FEATURE COLUMNS
# sfc point
point1 <- st_point(c(5, 2))
point2 <- st_point(c(1, 3))
points_sfc <- st_sfc(point1, point2)
points_sfc

# sfc polygon
polygon_list1 <- list(rbind(c(1, 5), c(2, 2), c(4, 1), c(4, 4), c(1, 5)))
polygon1 <- st_polygon(polygon_list1)
polygon_list2 <- list(rbind(c(0, 2), c(1, 2), c(1, 3), c(0, 3), c(0, 2)))
polygon2 <- st_polygon(polygon_list2)
polygon_sfc <- st_sfc(polygon1, polygon2)
st_geometry_type(polygon_sfc)

# sfc multilinestring
multilinestring_list1 <- list(rbind(c(1, 5), c(4, 4), c(4, 1), c(2, 2), c(3, 2)), 
                             rbind(c(1, 2), c(2, 4)))
multilinestring1 <- st_multilinestring((multilinestring_list1))
multilinestring_list2 <- list(rbind(c(2, 9), c(7, 9), c(5, 6), c(4, 7), c(2, 7)), 
                             rbind(c(1, 7), c(3, 8)))
multilinestring2 <- st_multilinestring((multilinestring_list2))
multilinestring_sfc <- st_sfc(multilinestring1, multilinestring2)
st_geometry_type(multilinestring_sfc)

# sfc geometry
point_multilinestring_sfc <- st_sfc(point1, multilinestring1)
st_geometry_type(point_multilinestring_sfc)

# EPSG definition
points_sfc_wgs <- st_sfc(point1, point2, crs=4326)
st_crs(points_sfc_wgs)

# PROJ4STRING definition
st_sfc(point1, point2, crs="+proj=longlat +datum=WGS84 +no_defs")

# THE SF CLASS
lnd_point = st_point(c(0.1, 51.5))                 # sfg object
lnd_geom = st_sfc(lnd_point, crs = 4326)           # sfc object
lnd_attrib = data.frame(                           # data.frame object
  name = "London",
  temperature = 25,
  date = as.Date("2017-06-21")
)
lnd_sf = st_sf(lnd_attrib, geometry = lnd_geom)    # sf object

lnd_sf
class(lnd_sf)

# EXPLORE RASTER DATA --------------------