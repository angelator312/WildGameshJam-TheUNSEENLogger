extends Node2D
@export var tree_layer:TileMapLayer 
signal chop_tree
var pos:Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pos=tree_layer.local_to_map(position)
	chop_tree.connect(is_ended)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func changed():
	#self.call_deferred("is_ended")

func is_ended():
	print(pos," ",tree_layer.get_cell_atlas_coords(pos))
	if tree_layer.get_cell_atlas_coords(pos).x==-1:
		get_tree().paused=true
		$Node.visible=true
