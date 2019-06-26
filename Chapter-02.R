# Geocomputation with R
# Chapter 2

# LOAD LIBRARIES -------------------
library(sf)          # classes and functions for vector data
library(raster)      # classes and functions for raster data
library(spData)      # load geographic data
library(spDataLarge) # load larger geographic data

# EXPLORE VECTOR DATA --------------
# An introduction to simple features
vignette(package="sf") # see which vignettes are available
vignette("sf1")          # an introduction to the package

names(world)
plot(world)
summary(world["lifeExp"])
world_mini <- world[1:2, 1:3]
world_mini

# Why simple features?
# Conversion of objects between sf and sp packages
library(sp)
world_sp <- as(world, Class="Spatial")
world_sf <- st_as_sf(world_sp)

# Basic mapmaking
spplot(world_sp)  # plotting with sp package 
plot(world_sf)    # plotting with sf package
plot(world[3:6])
plot(world["pop"])

world_asia <- world[world$continent == "Asia", ]
asia <- st_union(world_asia)
plot(world["pop"], reset=FALSE)
plot(asia, add=TRUE, col="red")


