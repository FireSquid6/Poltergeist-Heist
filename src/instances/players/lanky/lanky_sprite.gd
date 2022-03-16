extends AnimatedSprite


onready var parent = get_parent()
onready var outline_material = preload("res://resources/materials/outline_material.tres")

func _process(delta):
	if parent.on_floor and (parent.velocity.x != 0):
		animation = "walking"
	else:
		animation = "idle"
	
	if parent.state == parent.STATES.CONTROLLED:
		material = outline_material
	else:
		material = null
