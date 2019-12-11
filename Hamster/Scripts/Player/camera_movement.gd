extends Camera

export var distance = 15
export var height = 8

func _ready():
	set_physics_process(true)
	set_as_toplevel(true) #makes camera move independent from parent

func _physics_process(d):
	var target = get_parent().get_global_transform().origin
	var pos = get_global_transform().origin
	var up = Vector3(0,1,0)
	
	var offset = pos - target
	
	offset = offset.normalized()*distance
	offset.y = height

	pos = target + offset

	look_at_from_position(pos, target, up)	