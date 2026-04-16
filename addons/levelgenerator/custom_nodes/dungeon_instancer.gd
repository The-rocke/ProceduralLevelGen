@tool
class_name DungeonInstancer
extends Node3D

@export var tilemap: RoomTilemap
@export var generator: LevelGen

@export var tile_width := 2.0
@export var tile_depth := 2.0

@export var tile_rows := 25
@export var tile_columns := 25

@export_tool_button("INSTANTIATE") var a = func b(): instance_level()

func _ready() -> void:
	instance_level()

func instance_level() -> void:
	clear_level()

	generator.level_width = tile_rows
	generator.level_height = tile_columns
	generator.generate()

	var level = generator.level

	var level_width = tile_rows * tile_width
	var level_depth = tile_columns * tile_depth
	
	for i in tile_rows:
		for j in tile_columns:
			# If there is a room at that coordinate
			if level[i][j] > 0:
				var inst = get_tile_instance(j, i).instantiate()
				
				var x_pos = -1 * (level_width/2 - (tile_width * j))
				var z_pos = -1 * (level_depth/2 - (tile_depth * i))
				inst.position = Vector3(x_pos, 0, z_pos)
				
				add_child(inst)

func get_tile_instance(tile_x: int, tile_y: int) -> PackedScene:
	var left_tile = Vector2(tile_x-1, tile_y)
	var right_tile = Vector2(tile_x+1, tile_y)
	var up_tile = Vector2(tile_x, tile_y-1)
	var down_tile = Vector2(tile_x, tile_y+1)
	
	var left_is_empty = generator.point_is_empty(left_tile)
	var right_is_empty = generator.point_is_empty(right_tile)
	var up_is_empty = generator.point_is_empty(up_tile)
	var down_is_empty = generator.point_is_empty(down_tile)

	if left_is_empty and right_is_empty and up_is_empty and down_is_empty:
		return tilemap.enclosed
	
	# SIDE TILES
	if left_is_empty and !right_is_empty and !up_is_empty and !down_is_empty:
		return tilemap.west_side
	elif !left_is_empty and right_is_empty and !up_is_empty and !down_is_empty:
		return tilemap.east_side
	elif !left_is_empty and !right_is_empty and up_is_empty and !down_is_empty:
		return tilemap.north_side
	elif !left_is_empty and !right_is_empty and !up_is_empty and down_is_empty:
		return tilemap.south_side
	
	# CORNER TILES
	elif left_is_empty and !right_is_empty and up_is_empty and !down_is_empty:
		return tilemap.northwest_corner
	elif !left_is_empty and right_is_empty and up_is_empty and !down_is_empty:
		return tilemap.northeast_corner
	elif left_is_empty and !right_is_empty and !up_is_empty and down_is_empty:
		return tilemap.southwest_corner
	elif !left_is_empty and right_is_empty and !up_is_empty and down_is_empty:
		return tilemap.southeast_corner
	
	# STRAIGHT TILES
	elif left_is_empty and right_is_empty and !up_is_empty and !down_is_empty:
		return tilemap.north_south_straight
	elif !left_is_empty and !right_is_empty and up_is_empty and down_is_empty:
		return tilemap.east_west_straight
	
	# DEADENDS
	elif left_is_empty and right_is_empty and up_is_empty and !down_is_empty:
		return tilemap.north_deadend
	elif left_is_empty and right_is_empty and !up_is_empty and down_is_empty:
		return tilemap.south_deadend
	elif left_is_empty and !right_is_empty and up_is_empty and down_is_empty:
		return tilemap.west_deadend
	elif !left_is_empty and right_is_empty and up_is_empty and down_is_empty:
		return tilemap.east_deadend

	else:
		return tilemap.centre

func clear_level() -> void:
	for i in get_children():
		i.queue_free()
