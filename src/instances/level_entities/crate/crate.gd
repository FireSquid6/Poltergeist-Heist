extends Movable
class_name Crate

export var heavy = false


func _init():
	pushable = true


func _physics_process(delta):
	on_floor = is_on_floor()
	
	process_movement()
	$Label.text = str(velocity)


func _process(_delta):
	if heavy:
		pushable = Global.players_combined
