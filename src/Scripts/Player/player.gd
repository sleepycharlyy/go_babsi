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

var time_start = 0
var time_now = 0
var str_elapsed = "00 : 00"

func _ready():
	
	set_physics_process(true)
	
	anim_player = get_node("Animation")
	
	$SpawnSound.play()
	
	time_start = OS.get_unix_time()
	

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
	#jumppad (layer 3)
	if $DetectJumpPad.is_colliding():
		vel.y += jump_power
		$JumpSound.play()
	#boostpad (layer 4)
	if $DetectBoostPad.is_colliding():	
		#jump
		vel.y += jump_power/2
		#get direction
		var rot = $DetectBoostPad.get_collider().get_rotation_degrees()
		var rot_y = round(rot.y)
		if(rot_y == 180 || rot_y == -180):
			vel.z -= jump_power/2
		elif(rot_y == 0):
			vel.z += jump_power/2
		elif(rot_y == 90):
			vel.x += jump_power/2
		elif(rot_y == -90):
			vel.x -= jump_power/2
		$JumpSound.play()
	#goal (layer 5)
	if $DetectGoal.is_colliding():
		$FinishLevelSound.play()
		emit_signal("level_finished")	
	#detect ground (layer 1)
	if $DetectGround.is_colliding(): #particles
		$CPUParticles.emitting = true
	else:
		$CPUParticles.emitting = false


	
	#check if out of bounds
	if (get_translation().y < -50):
		$OutOfBoundsSound.play()
		get_tree().reload_current_scene()


	#animate
	anim_player.play("player")
	
	#move player
	vel = move_and_slide(vel,Vector3(0,1,0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))
	
	
func _process(d):
	#time
	time_now = OS.get_unix_time()
	var elapsed = time_now - time_start
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	str_elapsed = "%02d : %02d" % [minutes, seconds]
	
	
	