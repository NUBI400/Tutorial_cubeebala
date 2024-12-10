extends Sprite2D

@export var speeed: int

var velocity = Vector2.ZERO

var atordoado = false

@export var recuo: int 

@export var hp: int

@export var cor : String

var particulas_sangue = preload("res://particula_sangue.tscn")

@onready var cor_atual = modulate

func _ready():
	var recuo = get_node("Recuo")
	recuo.timeout.connect(_on_recuo_timeout)


func movimento_basico_inimigo(delta):
	if Global.player != null and atordoado == false:
		velocity = global_position.direction_to(Global.player.global_position)
		global_position += velocity * speeed * delta
	elif atordoado:
		velocity = lerp(velocity, Vector2.ZERO,0.3)
		global_position += velocity * delta
		
	

	if hp <= 0 and Global.criacao_no_pai != null:
		if Global.camera != null:
			Global.camera.tremer_tela(80, 0.2)
		
			Global.pontos += 1
			var instancia_particula_sangue = Global.instantiate_node(particulas_sangue, global_position, Global.criacao_no_pai)
			instancia_particula_sangue.rotation = velocity.angle()
			instancia_particula_sangue.color = Color.from_hsv(cor_atual.h, 0.75, cor_atual.v)
			print(instancia_particula_sangue.color)
			
			queue_free()
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy_damage") and (atordoado == false || cor == "Branco"):
		modulate = Color.WHITE
		area.get_parent().queue_free()
		velocity = -velocity * recuo
		atordoado = true
		hp -= 1 
		$Recuo.start()
		if hp <= 0:
			Global.correr = true

func _on_recuo_timeout() -> void:
	modulate = cor_atual
	atordoado = false
 
