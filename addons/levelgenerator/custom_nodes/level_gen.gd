@abstract
class_name LevelGen
extends Node

@export var seed: int = 0

@export var level_width := 50:
	set(value):
		level_width = max(value, 0)
@export var level_height := 50:
	set(value):
		level_height = max(value, 0)

@export var max_value := 1
@export var min_value := 0

var level = []
var occupied_points = []

var rng: RandomNumberGenerator

func generate_empty_level() -> void:
	level = []
	occupied_points = []

	for x in level_width:
		var row = []
		for y in level_height:
			row.append(0)
		level.append(row)

func print_level() -> void:
	print('\n')
	for row in level:
		print(row)

# Grabs a random point in the level
func get_random_point() -> Vector2:
	# If level contains no data, return an invalid position
	if level == []:
		return Vector2(-1, -1)
	
	var x = rng.randi_range(0, level_width-1)
	var y = rng.randi_range(0, level_height-1)
	
	return Vector2(x,y)

func point_is_empty(point: Vector2) -> bool:
	if point.x < 0 or point.x >= level_width:
		return true
	if point.x < 0 or point.y >= level_width:
		return true
	if level[point.y][point.x] == 0:
		return true
	else:
		return false

# Gets the value of a point in the level
func get_point(point: Vector2) -> int:
	return level[point.y][point.x]

func get_size() -> int:
	return level_width * level_height

func get_rand_occupied_point() -> Vector2:
	var index = rng.randi_range(0, occupied_points.size()-1)
	return occupied_points[index]

func get_centre_coord() -> Vector2:
	return Vector2(level_width/2 -1, level_height/2 -1)

# Generate function is overwritten in child classes
@abstract
func generate()
