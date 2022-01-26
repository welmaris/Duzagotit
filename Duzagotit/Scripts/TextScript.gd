tool
extends RichTextEffect
class_name ControlText

var bbcode := "hover"

func _process_custom_fx(char_fx):
	
	var speed = char_fx.env.get("speed", 5.0)
	
	var offset := Vector2(0,20)
	char_fx.offset = offset
	
	return true
