extends Control

var scene_path_to_load

func _ready():
	#focus start button
	var button = $BG/Container/BackButton
	button.grab_focus()
	button.connect("pressed",self, "on_pressed", [button.scene_to_load])
		
func on_pressed(scene_to_load): #when button is pressed
	scene_path_to_load = scene_to_load
	$FadeIn.show() #fade
	$FadeIn.fade_in()

func _on_FadeIn_fade_finished(): #when fade is finished
	get_tree().change_scene(scene_path_to_load)
	

#volume changes
func _on_Volume_Slider_value_changed(value):
	print(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value/2)
	$AudioStreamPlayer.play()