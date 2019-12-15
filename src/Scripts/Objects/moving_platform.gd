extends KinematicBody

var vel = Vector3()

export var spd = 4
var acc = 5
var basis
var start_y

onready var player = get_node("/root/World/Player")
export var distance_y = 10

var end_y
var switch_going_up = true
var transl_base

var pushed_body = null
var pushed_vel = null

func _ready():
	set_physics_process(true)
	transl_base = get_translation()
	start_y = transl_base.y
	end_y = (start_y + distance_y)	
	
func _physics_process(d):
	basis = get_global_transform().basis
	transl_base = get_translation()
	
	var dir = Vector3()
	if(transl_base.y >= end_y):
		switch_going_up = false
	elif(transl_base.y <= start_y):
		switch_going_up = true

	
	if(switch_going_up == true):
		dir += basis.y
	elif(switch_going_up == false):
		dir -= basis.y

	
	dir = dir.normalized()
	vel = vel.linear_interpolate(dir * spd, acc * d)
	var collision = move_and_collide(vel * d)
	if collision:
		collision.collider.move_and_collide(vel * d)
		pushed_body = collision.collider
		pushed_vel = vel