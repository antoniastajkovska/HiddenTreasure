extends CharacterBody3D

@onready var hud = get_node("/root/Main/HUD")

const SPEED = 5.0
const JUMP_VELOCITY = 8.0
const ROTATION_SPEED = 5.0
const CAMERA_FOLLOW_SPEED = 5.0

var target_rotation_y := 0.0
var near_chest: Node3D = null
var chest_opened = false

func _physics_process(delta):
	
	# Smooth camera rotation
	if Input.is_action_pressed("cam_left"):
		target_rotation_y += deg_to_rad(-30) * delta * ROTATION_SPEED
	if Input.is_action_pressed("cam_right"):
		target_rotation_y += deg_to_rad(30) * delta * ROTATION_SPEED
	$Camera_Controller.rotation.y = lerp($Camera_Controller.rotation.y, target_rotation_y, delta * 5.0)

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta  # Or use get_gravity() in Godot 4.2+

	# Movement
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = ($Camera_Controller.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = lerp(velocity.x, 0.0, delta * 5.0)
		velocity.z = lerp(velocity.z, 0.0, delta * 5.0)

	# Rotate bird mesh smoothly
	if input_dir != Vector2.ZERO:
		var target_angle = $Camera_Controller.rotation.y - input_dir.angle() + deg_to_rad(90)
		$bird.rotation.y = lerp($bird.rotation.y, target_angle, delta * 10.0)

	move_and_slide()
	
	# Camera follow with delta
	$Camera_Controller.position = $Camera_Controller.position.lerp(position, delta * CAMERA_FOLLOW_SPEED)
	
	if Input.is_action_just_pressed("interact"):
		if near_chest:
			near_chest.open_chest()
			chest_opened = true


func _on_interaction_area_body_entered(body: Node3D):
	var chest = body.get_parent()
	if chest.is_in_group("chest"):
		near_chest = chest  # Store reference to the chest
		if !chest_opened:
			hud.get_node("ChestOpenLabel").visible = true

func _on_interaction_area_body_exited(body: Node3D):
	if body.get_parent() == near_chest:
		near_chest = null  # Clear reference when player leaves
		hud.get_node("ChestOpenLabel").visible = false

func _unhandled_input(event):
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$JumpSound.play()
