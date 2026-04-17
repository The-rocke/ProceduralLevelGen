@tool
class_name AntNestGen
extends ProceduralGen

@export var hub_count := 10

var hub_list = []

func generate() -> void:
	hub_list = []
	rng = RandomNumberGenerator.new()
	rng.seed = seed

	# Creates "hubs" at random positions
	for i in hub_count:
		var pos = get_random_point()
		map.set_point(pos, 1)
		hub_list.append(pos)
	
	for h in hub_list.size()-1:
		var hub = hub_list[h]
		
		if h <= hub_list.size()-3:
			spawn_ant(hub, hub_list[h+1])
			spawn_ant(hub, hub_list[h+2])
		elif h == hub_list.size()-2:
			spawn_ant(hub, hub_list[h+1])
			spawn_ant(hub, hub_list[0])
		elif h == hub_list.size()-1:
			spawn_ant(hub, hub_list[0])
			spawn_ant(hub, hub_list[1])

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
		map.set_point(ant_position, 1)

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
