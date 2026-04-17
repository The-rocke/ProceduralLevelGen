class_name VoronoiMap
extends ProceduralGen

@export var sections := 10

var seed_placements = []

func generate():
	seed_placements = []
	generate_empty_map()

	rng = RandomNumberGenerator.new()
	rng.seed = seed
	
	for i in sections:
		var pos = get_random_point()
		map.set_point(pos, i+1)
		seed_placements.append(pos)

	for x in width:
		for y in height:
			var section_index = find_closest_section(Vector2(x,y))
			map.set_point(Vector2(x,y), section_index+1)

# Returns index of the closest section
func find_closest_section(point: Vector2) -> int:
	if seed_placements.has(point):
		return seed_placements.find(point)
	
	var closest_seed_index = 0
	var closest_dist = map.get_chebyshev_distance(point, seed_placements[0])
	
	for i in seed_placements.size():
		var seed_pos = seed_placements[i]

		var new_dist = map.get_chebyshev_distance(point, seed_pos)
		
		if new_dist < closest_dist:
			closest_dist = new_dist
			closest_seed_index = i
	
	return closest_seed_index
