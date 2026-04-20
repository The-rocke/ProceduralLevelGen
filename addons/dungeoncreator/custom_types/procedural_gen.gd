@abstract
class_name ProceduralGen
extends Node

@export var seed := 0

@export var width := 50:
	set(value):
		width = max(value, 0)
		map.width = width
@export var height := 50:
	set(value):
		height = max(value, 0)
		map.height = height

var map = Map.new(width, height)

var occupied_points = []

var rng = RandomNumberGenerator.new()

func generate_empty_map() -> void:
	occupied_points = []
	map.create_map(0)

func set_width(new_width: int) -> void:
	width = new_width
	map.width = width

func set_height(new_height: int) -> void:
	height = new_height
	map.height = height

# Grabs a random point in the level
func get_random_point() -> Vector2:
	# If level contains no data, return an invalid position
	if map.map == []:
		return Vector2(-1, -1)
	
	var x = rng.randi_range(0, width-1)
	var y = rng.randi_range(0, height-1)
	
	return Vector2(x,y)

func get_rand_occupied_point() -> Vector2:
	var index = rng.randi_range(0, occupied_points.size()-1)
	return occupied_points[index]

func point_is_empty(pos: Vector2) -> bool:
	if pos.x < 0 or pos.x >= width:
		return true
	if pos.y < 0 or pos.y >= height:
		return true
	if map.get_point(pos) == 0:
		return true
	else:
		return false

# Generates an empty level
func generate_all_walls() -> void:
	map.create_map(0)
# Generates a level with only floors
func generate_all_floors() -> void:
	map.create_map(1)

@abstract
func generate()
