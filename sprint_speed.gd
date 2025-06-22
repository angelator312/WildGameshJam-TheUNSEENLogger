extends Node2D



func _on_h_slider_gamepad_value_changed(value: float) -> void:
	if Input.is_action_pressed("my_left") or Input.is_action_pressed("my_right"):
		$HSliderGamepad.value=GlobalScript.sprint_speed
		return
	
	$Label.text="Sprint Speed:"+str(value)
	GlobalScript.sprint_speed=value
