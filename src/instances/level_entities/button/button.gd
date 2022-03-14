extends Area2D
class_name GameButton


var pressed = false
signal pressed()
signal released()

func _on_Button_body_entered(body):
	emit_signal("pressed")
	pressed = true
	$AnimatedSprite.frame = 1


func _on_Button_body_exited(body):
	emit_signal("released")
	pressed = false
	$AnimatedSprite.frame = 0
