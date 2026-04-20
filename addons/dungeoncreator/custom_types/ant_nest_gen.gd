@tool
class_name AntNestGen
extends ProceduralGen

@export var hub_count := 10

@export var min_ants := 2
@export var max_ants := 3

var hub_list = []

func generate() -> void:
	hub_list = []
	rng = RandomNumberGenerator.new()
	rng.seed = seed

	# Creates "hubs" at random positions
	for i in hub_count:
		var pos = get_random_point()
		
		if map.get_point(pos) == 0:
			map.set_point(pos, 1)
			occupied_points.append(pos)
		
		hub_list.append(pos)
	
	for h in hub_list.size()-1:
		var hub = hub_list[h]
		
		var ants = rng.randi_range(min_ants, max_ants)
		for a in range(1, ants+1):
			if h <= hub_list.size()-1-a:
				spawn_ant(hub, hub_list[h+a])
			else:
				spawn_ant(hub, hub_list[-ants+a])

func spawn_ant(start: Vector2, end: Vector2) -> void:
	var ant_position = start
	
	var direction_list = [0, 1, 2, 3]
	
	# ANT WILL MOVE TOWARDS THE END POSITION
	while ant_position != end:
		direction_list = [0, 1, 2, 3]
		
		# Can't move up
		if ant_position.y < end.y:
			direction_list.erase(0)
		# Can't move down
		if ant_position.y > end.y:
			direction_list.erase(1)
		# Can't move left
		if ant_position.x < end.x:
			direction_list.erase(2)
		# Can't move right
		elif ant_position.x > end.x:
			direction_list.erase(3)
		
		var index = rng.randi_range(0, direction_list.size()-1)
		var direction = direction_list[index]
		
		var velocity = get_velocity(direction)
		ant_position += velocity
		
		if map.get_point(ant_position) == 0:
			map.set_point(ant_position, 1)
			occupied_points.append(ant_position)

func get_velocity(direction: int) -> Vector2:
	match direction:
		# UP
		0:
			return Vector2(0, -1)
		# DOWN
		1:
			return Vector2(0, 1)
		# LEFT
		2:
			return Vector2(-1, 0)
		3:
			return Vector2(1, 0)
	
	# Else, defaults to right
	return Vector2(1, 0)
