extends RichTextLabel
 
var ms = 0
var s = 0
var m = 0 
var h = 0

func _process(delta):
	
	if ms >59:   
		s += 1
		ms = 0
	
	if s > 59:
		m += 1
		s = 0
	
	if m > 59:
		h += 1
		m = 0
		
	
	set_text(str(h)+":"+str(m)+":"+str(s)+":"+str(ms))
	
	pass
	
func _on_timer_timeout():
	ms += 1
	
	
	pass # Replace with function body.
