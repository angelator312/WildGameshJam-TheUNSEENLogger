extends CharacterBody2D
@export var enable_camera:=false
@export var enable_gravity:=false
@export var tree_layer:TileMapLayer
@export var explode_scene:PackedScene=preload("res://explode.tscn")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const SPRINT_ACCELERATE=2
signal chop_tree
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
			
		
	if direction:
		velocity.x*=lerp(1,SPRINT_ACCELERATE,Input.get_action_strength("sprint"))
	if directionY:
		velocity.y*=lerp(1,SPRINT_ACCELERATE,Input.get_action_strength("sprint"))
	var norm= velocity.normalized()
	if norm.x and norm.y:
		norm.x=0
		if norm.y>0:norm.y=1
		else:norm.y=-1
	if direction:
		var vel=norm.x
		if vel==-1 and animation_player.current_animation!="walk_left":
			animation_player.play("walk_left")
		if vel==1 and animation_player.current_animation!="walk_right":
			animation_player.play("walk_right")
	if directionY:
		var vel=norm.y
		if vel==-1 and (animation_player.current_animation!="walk_up"):
			animation_player.play("walk_up")
		if vel==1 and animation_player.current_animation!="walk_down":
			animation_player.play("walk_down")
	if !(direction or directionY):animation_player.play("stop")
	move_and_slide()
func chop():
	var pos=tree_layer.local_to_map(position)
	if tree_layer.get_cell_atlas_coords(pos).x>-1:
		chopPos(pos)
		var expl=explode_scene.instantiate()
		expl.z_index=-1
		expl.position=position+Vector2(0,-20)
		get_parent().add_child(expl)
		expl.explode()
		chop_tree.emit()
		
func chopPos(start_pos:Vector2):
	var q:Array
	var minati:Array
	q.push_back(start_pos)
	while(!q.is_empty()):
		var pos=q.front()
		q.pop_front()
		var cord= tree_layer.get_cell_atlas_coords(pos)
		if cord.x>-1:
			if(minati.find(cord)>-1):continue
			minati.push_back(cord)
			tree_layer.set_cell(pos)
			const vectors=[Vector2(0,1),Vector2(0,-1),Vector2(1,0),Vector2(-1,0),]
			for e in vectors:
				q.push_back(pos+e)

func play_walk_down():
	animated_sprite_2d.play("walk_down")

func play_walk_up():
	animated_sprite_2d.play("walk_up")

func play_walk_left():
	animated_sprite_2d.play("walk_left")


func play_walk_right():
	animated_sprite_2d.play("walk_right")

func stop_walk():
	animated_sprite_2d.stop()
