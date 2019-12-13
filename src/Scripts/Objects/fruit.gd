extends Spatial

onready var player = get_node("/root/World/Player")

func _ready():
	$Anim.play("fruit")

func _on_Area_body_entered(body):
	if(player == body):
		print("test")
		queue_free()
		player.score += 1
		player.get_node("CollectiblesSound").play()
