class_name ExplodeParticle extends AnimatedSprite2D

func explode():
	self.visible=true
	self.play("first")
	SodaAudioManager.play_interface_sfx("explosion-sfx.mp3",0.5)

func _on_animation_finished() -> void:
	queue_free()
