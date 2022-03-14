extends Area2D
class_name GameButton


var pressed = false
signal pressed()
signal released()

func _on_Button_body_entered(body):
	emit_signal("pressed")
	pressed = true
	$Polygon2D.scale.y = 0.5


func _on_Button_body_exited(body):
	emit_signal("released")
	pressed = false
	$Polygon2D.scale.y = 1
