extends CanvasLayer

onready var player = get_node("/root/World/Player")
export var scene_to_switch_to = "res://Scenes/Levels/Titlescreen/Titlescreen.tscn"
var can_paused = true

func _ready():
	can_paused = true
	get_tree().paused = false

func _process(d):
	var x = player.get_translation().x 
	var y =	player.get_translation().y
	var z =	player.get_translation().z
	var fps = Engine.get_frames_per_second()
	#get_node("Debug").set_text("x:" + str(x) + " y:" + str(y) + " z:" + str(z) + " fps:" + str(fps))
	get_node("Score").set_text("x " + str(player.score))
	get_node("Time").set_text(player.str_elapsed) 
		
	
func _input(event):
	if(can_paused):
		if event.is_action_pressed("button_pause"):
			var new_pause_state = not get_tree().paused
			get_tree().paused = not get_tree().paused
			$Pause.visible = new_pause_state
			$PlayAccept.play()



func _on_Player_level_finished():
	can_paused = false
	if($Pause.visible == true): 
		$Pause.visible = false
	get_tree().paused = true
	$Finished.visible = true
	$Score.visible = false
	$Time.visible = false
	$Finished/Next.grab_focus()
	$Finished/Score.set_text("Score: " + str(player.score))
	$Finished/Time.set_text("Time: " + player.str_elapsed)

func _on_Back_pressed():
	$PlayAccept.play()
	can_paused = true
	get_tree().paused = false
	get_tree().change_scene(scene_to_switch_to)

