extends Area2D


export(float) var time = 5
onready var pressed = false

signal timer_started()
signal timer_stopped()


func _physics_process(delta):
	if pressed:
		$Press.play()
		$Label.text = str(floor($Timer.time_left))
	else:
		$Label.text = str(floor(time))
		if len(get_overlapping_bodies()) > 0:
			pressed = true
			$Polygon2D.position.y += 1
			$Timer.wait_time = time
			$Timer.start()
			
			emit_signal("timer_started")


func _on_Timer_timeout():
	$Press.play()
	emit_signal("timer_stopped")
	pressed = false
	$AnimatedSprite.stop()
	$Polygon2D.position.y -= 1
