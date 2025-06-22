extends Node

func quit():
	get_tree().quit();

func change_to(a:String):
	get_tree().call_deferred("change_scene_to_file",a)
