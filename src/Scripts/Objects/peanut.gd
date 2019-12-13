extends Spatial

onready var player = get_node("/root/World/Player")

func _ready():
	$Aniam.play("peanut")

func _on_Area_body_entered(body):
	if(player == body):
		queue_free()
		player.peanut = true
		player.get_node("CollectiblesSound").play()
