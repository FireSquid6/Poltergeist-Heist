extends Toggleable


func turn_on():
	$CollisionShape2D.set_deferred("disabled", true)
	$Polygon2D.color = Color(0.31, 0.2, 0.17, 0.5)

func turn_off():
	$CollisionShape2D.set_deferred("disabled", false)
	$Polygon2D.color = Color(0.31, 0.2, 0.17, 1)
