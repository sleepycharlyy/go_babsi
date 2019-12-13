extends CPUParticles

onready var player = get_node("/root/World/Player")
var offset = Vector3(0,20,0)

func _process(d):
	set_translation(player.get_translation()+offset)
	set_rotation(Vector3(0,0,0))