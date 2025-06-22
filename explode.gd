class_name ExplodeParticle extends AnimatedSprite2D

func explode():
	self.visible=true
	self.play("first")

func _on_animation_finished() -> void:
	queue_free()
