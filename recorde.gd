extends Label

func _ready():
	text = str(Global.recorde)
	
func _process(delta):
	if Global.pontos > Global.recorde:
		Global.recorde = Global.pontos
