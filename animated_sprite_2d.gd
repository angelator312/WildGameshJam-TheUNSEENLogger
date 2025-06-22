extends CharacterBody2D
@export var enable_camera:=false
@export var enable_gravity:=false
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
func _ready():
	$Camera2D.enabled=enable_camera

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if (not is_on_floor()) and enable_gravity:
		velocity += get_gravity() 

	# Handle jump.

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	var directionY := Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
