extends CharacterBody3D


const SPEED = 50
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	
	velocity.x = Input.get_axis("ui_left", "ui_right") * SPEED * delta
	velocity.z = Input.get_axis("ui_up","ui_down") * SPEED * delta
	velocity = velocity.rotated(Vector3.UP, $SpringArm3D.rotation.y)
	
	velocity.y += get_gravity().y * delta

	move_and_slide()
