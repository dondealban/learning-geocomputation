# Geocomputation with R
# Chapter 2

# LOAD LIBRARIES -------------------
library(sf)          # classes and functions for vector data
library(raster)      # classes and functions for raster data
library(spData)      # load geographic data
library(spDataLarge) # load larger geographic data

# LOAD VIGNETTES -------------------
vignette(package="sf") # see which vignettes are available
vignette("sf1")          # an introduction to the package

# EXPLORE VECTOR DATA --------------
names(world)
plot(world)
summary(world["lifeExp"])
world_mini <- world[1:2, 1:3]
world_mini

# Conversion of objects between sf and sp packages
library(sp)
world_sp <- as(world, Class="Spatial")
world_sf <- st_as_sf(world_sp)


