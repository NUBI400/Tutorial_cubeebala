extends Camera2D

var intensidade_tremor_camera = 0

var iniciar_tremor_camera = false

func _process(delta: float):
	zoom = lerp(zoom, Vector2(1,1), 0.3)
	
	if iniciar_tremor_camera == true:
		global_position += Vector2(randf_range(-intensidade_tremor_camera, intensidade_tremor_camera), randf_range(-intensidade_tremor_camera, intensidade_tremor_camera)) * delta

func tremer_tela(intensidade, tempo):
	zoom = Vector2(1,1) - Vector2(intensidade * 0.002, intensidade * 0.002)
	intensidade_tremor_camera = intensidade
	$Timer_camera.wait_time = tempo
	$Timer_camera.start()
	iniciar_tremor_camera = true

func _ready():
	Global.camera = self
	
func _exit_tree():
	Global.camera = null
	

func _on_timer_camera_timeout():
	iniciar_tremor_camera = false
