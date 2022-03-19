extends Node


func _ready():
	get_parent().get_node("Controller").queue_free()
	Global.new_node.stop()
