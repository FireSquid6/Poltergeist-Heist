extends Area2D


export(PackedScene) var next_level = null
export(bool) var play_finish_sound = true
onready var level = get_parent().get_parent()


func _on_Gate_body_entered(body):
	print(body.name + " triggered the next level")
	if play_finish_sound:
		$FinishSFX.play()
	
	if next_level != null:
		level.change_level(next_level.resource_path)
	else:
		level.restart_level()
		print("No level to move to set")
