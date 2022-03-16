extends TextureRect


onready var hover_material = preload("res://resources/materials/outline_material.tres")
onready var hovered = false
onready var level = get_tree().get_root().get_child(1)


func _ready():
	pass

func _process(delta):
	if hovered and Input.is_action_just_pressed("mouse_left"):
		level.restart_level()


func _on_Restart_mouse_entered():
	hovered = true
	material = hover_material


func _on_Restart_mouse_exited():
	hovered = false
	material = null
