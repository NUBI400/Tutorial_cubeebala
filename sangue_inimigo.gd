extends Node2D

var fade = false

var alpha = 1

func _process(delta):
	if fade:
		alpha = lerpf(alpha, 0, 0.1)
		modulate.a = alpha
	
		if alpha < 0.0005:
			queue_free()


func _on_fade_out_timer_timeout():
	fade = true
