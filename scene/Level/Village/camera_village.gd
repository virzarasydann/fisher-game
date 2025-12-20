extends Camera2D


@export var player: CharacterBody2D
@export var tilemap: TileMapLayer

func _ready():
	zoom = Vector2(1.2, 1.2)
	setup_camera_limits()

func _process(delta):
	if player:
		global_position = player.global_position

func setup_camera_limits():
	if tilemap == null:
		return
	var map_rect = tilemap.get_used_rect()
	
	var tile_size = tilemap.tile_set.tile_size
	
	var world_size_in_pixels = map_rect.position * tile_size
	
	var world_end_in_pixels = (map_rect.position + map_rect.size) * tile_size
	

	limit_left = int(world_size_in_pixels.x)
	limit_top = int(world_size_in_pixels.y)
	limit_right = int(world_end_in_pixels.x)
	limit_bottom = int(world_end_in_pixels.y)
