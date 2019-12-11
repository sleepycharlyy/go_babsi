extends KinematicBody

#initialize

signal level_finished
var spd = 23
var rot_spd = 3
var acc = 5
var grav = 7
var jump_power = 300
const MAX_SLOPE_ANGLE = 65
var vel = Vector3()
var anim_player
var score = 0

func _ready():
	set_physics_process(true)
	anim_player = get_node("Animation")
	$SpawnSound.play()

func _physics_process(d):
	#var
	var basis = get_global_transform().basis
	var dir = Vector3()
	
	#inputs
	if Input.is_action_pressed("button_a"): #left
		rotate_y(rot_spd*d);
	if Input.is_action_pressed("button_b"): #right
		rotate_y(-rot_spd*d);
	
	#apply movement
	dir += basis.z
	dir = dir.normalized()
	vel = vel.linear_interpolate(dir * spd, acc * d)
	vel.y -= grav
	
	#raycast (detect ground)
	#collectibles (layer 2)
	if $DetectCollectibles.is_colliding():
		$DetectCollectibles.get_collider().queue_free()
		score += 1
		$CollectiblesSound.play()
	if $DetectFruits.is_colliding():
		$DetectFruits.get_collider().queue_free()
		score += 1
		$CollectiblesSound.play()
	#jumppad (layer 3)
	if $DetectJumpPad.is_colliding():
		vel.y += jump_power
		$JumpSound.play()
	#boostpad (layer 4)
	if $DetectBoostPad.is_colliding():	
		pass
	#goal (layer 5)
	if $DetectGoal.is_colliding():
		$FinishLevelSound.play()
		emit_signal("level_finished")	
		#get_tree().change_scene("res://Scenes/Levels/Titlescreen/")
	

	
	#check if out of bounds
	if (get_translation().y < -50):
		$OutOfBoundsSound.play()
		get_tree().reload_current_scene()


	#animate
	anim_player.play("player")
	
	#move player
	vel = move_and_slide(vel,Vector3(0,1,0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))
	

	
	