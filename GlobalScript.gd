extends Node
const background_music:Array[String]=["neshto","res://music/chill-beats.mp3","res://music/relaxed-energy-chill-game-music.mp3"]
var background_music_idx=0
var background_music_sz=background_music.size()
func quit():
	get_tree().quit();
func _ready() -> void:
	SodaAudioManager.music_finish.connect(next_background_music)
func change_to(a:String):
	get_tree().call_deferred("change_scene_to_file",a)

var sprint_speed:=2.0
func next_background_music():
	background_music_idx+=1
	if background_music_idx==background_music_sz:
		background_music_idx=1
	SodaAudioManager.play_music(background_music[background_music_idx],1)
