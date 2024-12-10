extends Label
 
func _process(delta: float) -> void:
	if Global.correr == true:
		text = "DASH ON"
	elif  Global.correr == false:
		text = "DASH FALSE"
	
	
	
