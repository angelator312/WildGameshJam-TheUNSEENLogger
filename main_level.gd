extends Node2D

func _ready() -> void:
	on_ready_audio()
func on_ready_audio():
	var mp="none"
	if SodaAudioManager.currentMusic:mp=SodaAudioManager.currentMusic.resource_path
	
	print(mp)
	if mp=="none":
		GlobalScript.next_background_music()
	
func _on_quit_body_entered(body: Node2D) -> void:
	GlobalScript.quit()
	pass # Replace with function body.
