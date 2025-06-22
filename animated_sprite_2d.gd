extends CharacterBody2D
@export var enable_camera:=false
@export var enable_gravity:=false
@export var tree_layer:TileMapLayer
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const SPRINT_ACCELERATE=2
func _ready():
	$Camera2D.enabled=enable_camera
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("chop") and event.is_pressed():
		chop()
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if (not is_on_floor()) and enable_gravity:
		velocity += get_gravity() 
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
	velocity*=lerp(1,SPRINT_ACCELERATE,Input.get_action_strength("sprint"))
	move_and_slide()
func chop():
	var pos=tree_layer.local_to_map(position)
	if tree_layer.get_cell_atlas_coords(pos).x>-1:
		chopPos(pos)
		
		#TODO: Implement deleting the entire tree
		
func chopPos(pos:Vector2):
	if tree_layer.get_cell_atlas_coords(pos).x>-1:
		tree_layer.set_cell(pos)
		const vectors=[Vector2(0,1),Vector2(1,0),Vector2(0,-1),Vector2(-1,0),]
		for e in vectors:
			chopPos(pos+e)
