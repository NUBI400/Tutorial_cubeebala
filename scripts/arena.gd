extends Node2D

var inimigo_1 = preload("res://enemy.tscn")

@export var inimigos: Array[PackedScene]

func _ready() -> void:
	Global.criacao_no_pai = self
	Global.pontos = 0
	
func _exit_tree() -> void:
	Global.criacao_no_pai = null
		

func _on_timer_spawn_inimigo_timeout() -> void:
	var posicao_inimigo = Vector2(randf_range(-320,1300),randf_range(-180,800))
	
	while posicao_inimigo.x < 1280 and posicao_inimigo.x > -80 and posicao_inimigo.y < 720 and posicao_inimigo.y > -45:
		posicao_inimigo = Vector2(randf_range(-320,1300),randf_range(-180,800))
		
	
	var numero_inimigos = round(randf_range(0, inimigos.size() -1 ))
	Global.instantiate_node(inimigos[numero_inimigos], posicao_inimigo, self)


func _on_timer_dificuldade_timeout():
	if $Timer_spawn_inimigo.wait_time > 0.50:
		$Timer_spawn_inimigo.wait_time -= 0.025
