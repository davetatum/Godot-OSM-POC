# Godot-OSM-POC
POC for an AR game with Godot using data from Open Street Maps

![POC Screen Shot](Images/ScreenShot.png)

## Requirements
- Godot 4.3: <https://godotengine.org/>
- Open Street Maps (OSM): <https://www.openstreetmap.org>

## Open Street Map Usage
If using this code unmodified please read and understand the [usage guildelines for the tile server](https://operations.osmfoundation.org/policies/tiles/). This service is provided by OSM free and funded by donation.  If using this code for a released project, you should consider hosting your own tile server or paying for a comercial service.

## Map Tiles
This POC uses raster tiles (256x256) that are pre-renderd by OSM.  There are multiple freely available [tile servers](https://wiki.openstreetmap.org/wiki/Raster_tile_providers) that have different styles.  Alternativey this could be extended to use [vector tiles](https://wiki.openstreetmap.org/wiki/Vector_tiles#Mapbox_Vector_Tiles) or you can [create your own](https://wiki.openstreetmap.org/wiki/Rendering) pre-rendered raster tiles


## Getting Started with this POC
This project should run without modification once imported in Godot 4.3.  

### Map Location
The default location is set to center city Philadelpiha.  This lat/lon serves only as a starting location and from there wasd movement determines map position. To modify your starting location, the Map Container exposes a latitude and Longitude that can be modified before the game is launched.

### Map Size and Zoom
The map container also exposes height and width variables that determine the number of tiles to be loaded at runtime.

***Note:** please be mindful how much data you are requesting from OSM.  They provide this for free, so let's be good FOSS citizens. 

Zoom determines the level of detail you'll see when viewing the map.  This can also be set on the Map Container before running.  Valid values range from 0-19.  0 being the lowest level of detail, with 1 tile representing the entire map.  For every integer increase each tile is split into 4, increasing the number of tiles exponentially. The default value is 19 which shows the most detail.  