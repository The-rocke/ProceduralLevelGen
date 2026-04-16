@tool
class_name DrunkenwalkGen
extends LevelGen

@export var steps := 64
@export_range(0.0, 60.0, 0.1) var min_coverage_percent := 30.0:
	set(value):
		min_coverage_percent = value
		min_coverage = min_coverage_percent/100 * get_size()
var min_coverage = min_coverage_percent/100 * get_size()

@export_tool_button("GENERATE") var gen_btn = func a(): generate()

var current_pos
var prev_direction = 4

func _enter_tree():
	min_coverage = min_coverage_percent/100 * get_size()

func generate():
	prev_direction = 4
	generate_empty_level()

	rng = RandomNumberGenerator.new()
	rng.seed = seed
	
	walk(get_centre_coord())
	
	var coverage = occupied_points.size()
	
	var i = 1
	while coverage < min_coverage and i < 100:
		walk(get_rand_occupied_point())
		coverage = occupied_points.size()
		i += 1

func walk(start: Vector2):
	level[start.y][start.x] = 1

	current_pos = start

	for i in steps:
		step()

func step():
	var direction = -1
	var possible_directions = get_available_directions()
	
	# IF NO POSSIBLE DIRECTIONS EXIST
	if possible_directions.size() == 0:
		return
	else:
		var index = rng.randi_range(0, possible_directions.size()-1)
		direction = possible_directions[index]
	
	if direction == 0:
		current_pos.y -= 1
	elif direction == 1:
		current_pos.y += 1
	elif direction == 2:
		current_pos.x -= 1
	elif direction == 3:
		current_pos.x += 1
	
	if get_point(current_pos) == 0:
		occupied_points.append(current_pos)
		level[current_pos.y][current_pos.x] = clamp(level[current_pos.y][current_pos.x]+1, min_value, max_value)
	
	prev_direction = direction

func get_available_directions() -> Array:
	var directions = [0, 1, 2, 3]
	
	if current_pos.y == 0 or get_point(Vector2(current_pos.x, current_pos.y-1)) != 0:
		directions.erase(0)
	if current_pos.y == level_height-1 or get_point(Vector2(current_pos.x, current_pos.y+1)) != 0:
		directions.erase(1)
	if current_pos.x == 0 or get_point(Vector2(current_pos.x-1, current_pos.y)) != 0:
		directions.erase(2)
	if current_pos.x == level_width-1 or get_point(Vector2(current_pos.x+1, current_pos.y)) != 0:
		directions.erase(3)
	
	return directions
