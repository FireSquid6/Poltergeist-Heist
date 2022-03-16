extends Label


onready var level = get_tree().get_root().get_child(1)

func _ready():
	text = level.level_name
