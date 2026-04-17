@tool
class_name DrunkenWalkGen
extends ProceduralGen

@export var steps := 64

@export_range(0.0, 60.0, 0.1) var min_coverage_percent := 30.0:
	set(value):
		min_coverage_percent = value
		min_coverage = min_coverage_percent/100 * map.get_size()
var min_coverage = min_coverage_percent/100 * map.get_size()

var current_pos
var prev_direction = 4

func _enter_tree():
	min_coverage = min_coverage_percent/100 * map.get_size()

func generate() -> void:
	var prev_direction = 4

	rng = RandomNumberGenerator.new()
	rng.seed = seed
	
	walk(map.get_centre_coord())
	
	var coverage = occupied_points.size()

	var i = 1
	while coverage < min_coverage:
		# Creates a new drunken walker at a random occupied point
		walk(get_rand_occupied_point())
		
		coverage = occupied_points.size()
		i += 1
	
	map.print_map()

func walk(start: Vector2):
	map.set_point(start, 1)

	current_pos = start

	for i in steps:
		step()

func step():
	var direction = -1
	var possible_directions = get_available_directions()
	
	# IF NO POSSIBLE DIRECTIONS EXIST
	if possible_directions.size() == 0:
		return
	# ELSE
	var index = rng.randi_range(0, possible_directions.size()-1)
	direction = possible_directions[index]
	
	# UP
	if direction == 0:
		current_pos.y -= 1
	# DOWN
	elif direction == 1:
		current_pos.y += 1
	# LEFT
	elif direction == 2:
		current_pos.x -= 1
	# RIGHT
	elif direction == 3:
		current_pos.x += 1
	
	if map.get_point(current_pos) == 0:
		occupied_points.append(current_pos)
		map.set_point(current_pos, 1)
	
	prev_direction = direction

func get_available_directions() -> Array:
	var directions = [0, 1, 2, 3]
	
	# Removes directions that lead to an invalid index or already occupied tile
	if current_pos.y == 0 or map.get_point(Vector2(current_pos.x, current_pos.y-1)) != 0:
		directions.erase(0)
	if current_pos.y == height-1 or map.get_point(Vector2(current_pos.x, current_pos.y+1)) != 0:
		directions.erase(1)
	if current_pos.x == 0 or map.get_point(Vector2(current_pos.x-1, current_pos.y)) != 0:
		directions.erase(2)
	if current_pos.x == width-1 or map.get_point(Vector2(current_pos.x+1, current_pos.y)) != 0:
		directions.erase(3)
	
	return directions
