extends ColorRect

signal fade_finished

func fade_in():
	$FadeInAnimation.play("fade_in") #play fadein

func _on_FadeInAnimation_animation_finished(anim_name): #check if anim finished
	emit_signal("fade_finished") #emitsignal
