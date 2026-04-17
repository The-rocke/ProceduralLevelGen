class_name Map
extends Object

@export var width := 50:
	set(value):
		width = max(value, 0)
@export var height := 50:
	set(value):
		height = max(value, 0)

var map = []

func _init(width: int, height: int) -> void:
	self.width = width
	self.height = height
	
	clear_map()
	create_map(0)

func create_map(default_value: int) -> void:
	map = []
	
	for y in height:
		var row = []
		for x in width:
			row.append(default_value)
		
		map.append(row)

func clear_map() -> void:
	map = []

func fill(value: int) -> void:
	for y in height:
		for x in width:
			map[y][x] = value

# Gets the value of a point in the level
func get_point(pos: Vector2) -> int:
	return map[pos.y][pos.x]

func set_point(pos: Vector2, value: int) -> void:
	map[pos.y][pos.x] = value

func get_size() -> int:
	return width * height

func get_centre_coord() -> Vector2:
	return Vector2(width/2-1, height/2 -1)

func get_chebyshev_distance(p1: Vector2, p2: Vector2) -> int:
	return max(abs(p1.x-p2.x), abs(p1.y-p2.y))

func print_map():
	for row in map:
		print(row)
