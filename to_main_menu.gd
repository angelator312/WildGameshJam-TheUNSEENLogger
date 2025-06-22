extends Area2D


func _on_body_entered(body: Node2D) -> void:
	GlobalScript.change_to("level.tscn")
	pass # Replace with function body.
