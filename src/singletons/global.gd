extends Node


var music = preload("res://resources/sounds/Track 3.wav")

const GRAVITY = 30
var players_combined = false
var new_node = AudioStreamPlayer.new()


func _ready():
	add_child(new_node)
	
	new_node.stream = music
	new_node.play()
	new_node.volume_db = -6
