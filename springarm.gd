extends SpringArm3D

@export_range(0.0, 1.0) var mouse_sensitivity = 0.01
@export var tilt_limit = deg_to_rad(75)
@export var min_zoom = 3
@export var max_zoom = 10

@onready var camera = $Camera3D as Camera3D

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.x -= event.relative.y * mouse_sensitivity
		# Prevent the camera from rotating too far up or down.
		rotation.x = clampf(rotation.x, -tilt_limit, tilt_limit)
		rotation.y += -event.relative.x * mouse_sensitivity
	
	if event is InputEventMouseButton:
		# zoom out
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			spring_length += 0.2
			spring_length = clamp(spring_length, min_zoom, max_zoom)
		#	Zoom In
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			spring_length -= 0.2
			spring_length = clamp(spring_length, min_zoom, max_zoom)
