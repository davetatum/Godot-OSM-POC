extends Node3D

signal player_entered_world_tile(x, y, tile_position)

var current_tile

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tile = cast_ray_down()
	if tile and (!current_tile or (current_tile.tile_x != tile.tile_x or current_tile.tile_y != tile.tile_y)) :
		current_tile = tile
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
