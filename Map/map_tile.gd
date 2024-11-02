extends Node

var tile_zoom: int # Set the zoom level
var tile_x: int     # X coordinate of the tile
var tile_y: int     # Y coordinate of the tile


func init(x:int, y: int, zoom: int):
	tile_x = x
	tile_y = y
	tile_zoom = zoom

# Called when the node enters the scene tree
func _ready():
	var url = "https://tile.openstreetmap.org/%d/%d/%d.png" % [tile_zoom, tile_x, tile_y]
	fetch_tile_texture(url)

# Fetches the tile image from OSM and applies it as a texture
func fetch_tile_texture(tile_url: String):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	
	http_request.request_completed.connect(self._on_request_completed)
	
	var err = http_request.request(tile_url)
	if err != OK:
		print("Failed to request OSM tile: ", err)

# Callback for HTTP request completion
func _on_request_completed(_result: int, response_code: int, _headers: Array, body: PackedByteArray):
	if response_code == 200: # Check if the request was successful
		var image = Image.new()
		image.load_png_from_buffer(body)
		var texture = ImageTexture.create_from_image(image)
		# Set the texture on the plane's material
		apply_texture_to_plane(texture)
	else:
		print("Failed to load OSM tile, response code: ", response_code)

# Apply texture to the plane
func apply_texture_to_plane(texture: Texture2D):
	var material = StandardMaterial3D.new()
	material.albedo_texture = texture
	$Mesh.set_surface_override_material(0, material)
