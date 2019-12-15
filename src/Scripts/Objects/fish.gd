extends KinematicBody

onready var player = get_node("/root/World/Player")

func _ready():
	$FishArea/Animation.play("fish")

func _on_FishArea_body_entered(body):
	if(player == body):
		player.onDeath()
