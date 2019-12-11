extends Spatial

onready var anim = get_node("Animation");

var scene_path_to_load

func _ready():
	#focus start button
	$GUI/Menu/Buttons/StartButton.grab_focus()
	
	#get all buttons and connect them
	for button in $GUI/Menu/Buttons.get_children(): 
		button.connect("pressed",self, "on_pressed", [button.scene_to_load])

func _process(d):
	anim.play("titlescreen")
	
func _input(event):
	#play sounds
	if (event.is_action_pressed("ui_focus_next") || event.is_action_pressed("ui_focus_prev")):
		$SelectSound.play()
	if (event.is_action_pressed("ui_accept")):
		$AcceptSound.play()


#buttons & fade
func on_pressed(scene_to_load): #when button is pressed
	scene_path_to_load = scene_to_load
	$GUI/FadeIn.show() #fade
	$GUI/FadeIn.fade_in()

func _on_FadeIn_fade_finished(): #when fade is finished
	if(scene_path_to_load == "quit"): #if the button is the quit button
		get_tree().quit()
	
	get_tree().change_scene(scene_path_to_load)
	
