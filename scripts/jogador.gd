extends Sprite2D

var velocidade = 150 
var mov = Vector2.ZERO

var projetil = preload("res://projetil.tscn")
###estados###
const PARADO = 1
const ANDANDO = 2
const DASH = 3
const DASH_FUNC = 4
var estado_movimento = PARADO
###

var morto = false
var can_shoot = true

func _ready():
	Global.player = self

func _exit_tree():
	Global.player = null

func _process(delta: float) -> void:
	mov.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	mov.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	global_position.x = clamp(global_position.x, 24, 1256)
	global_position.y = clamp(global_position.y, 24, 696)
	if morto == false:
		global_position += velocidade * mov * delta
	
	if Input.is_action_pressed("atirar") and Global.criacao_no_pai != null and can_shoot and morto == false:
		Global.instantiate_node(projetil, global_position, Global.criacao_no_pai)
		$Reload_speed.start()
		can_shoot = false
	
	###maquina de estados###
	if estado_movimento == PARADO:
		funcao_parado()
	elif estado_movimento == ANDANDO:
		funcao_andando()
	elif estado_movimento == DASH_FUNC:
		funcao_dash_func()




func funcao_parado():
	if mov.x != 0:
		estado_movimento = ANDANDO
	
	if mov.y != 0:
		estado_movimento = ANDANDO
	
func funcao_andando():
	velocidade = 50
	if mov.x == 0:
		estado_movimento = PARADO
	
	if mov.y != 0:
		estado_movimento = ANDANDO
	
	if Global.correr == true:
		$Reload_dash.start()
		print("foi")
	#print(estado_movimento)
	
func funcao_dash_func():
	velocidade = 300

func _on_reload_dash_timeout():
	estado_movimento = DASH_FUNC
	$Reload_dash/Dash_timer.start()
	print("tempo")


func _on_dash_timer_timeout():
	Global.correr = false
	estado_movimento = PARADO
	print("funcionou")


################
func _on_reload_speed_timeout():
	can_shoot = true
	


func _on_hitbox_area_entered(area):
	if area.is_in_group("Enemy"):
		visible = false
		morto = true
		await get_tree().create_timer(1).timeout
		get_tree().reload_current_scene()





