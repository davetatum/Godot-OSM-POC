extends Node3D

signal player_entered_world_tile(x, y, tile_position)

var current_tile

@export var ray_cast_per_second: float = 4 
var time_since_last_cast: float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# reduce unnessesary ray casting
	if time_since_last_cast < 1.0/ray_cast_per_second:
		time_since_last_cast += delta
	else:
		time_since_last_cast = 0.0
		var tile = cast_ray_down()
		if tile and (!current_tile or (current_tile.tile_x != tile.tile_x or current_tile.tile_y != tile.tile_y)) :
			current_tile = tile
			# connects to the map_container to load new tiles if necesary as the player moves
			emit_signal("player_entered_world_tile", tile.tile_x, tile.tile_y, tile.position)

# find the tile the player is above, so we know when to expand the map
func cast_ray_down() -> Object:
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(position, position + Vector3(0, -10, 0))
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	# Check if there was a collision
	if result and !result.is_empty():
		return result.collider
	else:
		# we're lost/off the map 
		return null
