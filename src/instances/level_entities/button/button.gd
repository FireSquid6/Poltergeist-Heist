extends Area2D
class_name GameButton


var pressed = false
var last_pressed = false
export(bool) var heavy = false

signal pressed()
signal released()


func _physics_process(_delta):
	var overlapping = get_overlapping_bodies()
	var remove = false
	if heavy:
		for i in range(len(overlapping)):
			remove = true
			if overlapping[i] as Movable:
				if overlapping[i].heavy:
					remove = false
			
			if remove:
				overlapping.remove(i)
	
	pressed = (len(overlapping) > 0)
	
	if pressed != last_pressed:
		if pressed:
			emit_signal("pressed")
			$AnimatedSprite.frame = 1
			$Press.play()
		else:
			emit_signal("released")
			$AnimatedSprite.frame = 0
	
	
	last_pressed = pressed
