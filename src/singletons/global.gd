extends Node


var music = preload("res://resources/sounds/Track 3.wav")

const GRAVITY = 30
var players_combined = false
var new_node = AudioStreamPlayer.new()
var screenshots = 0

func _ready():
	add_child(new_node)
	
	new_node.stream = music
	new_node.play()
	new_node.volume_db = -6


func _process(delta):
	if Input.is_action_just_pressed("screenshot"):
		var image = get_viewport().get_texture().get_data()
		image.flip_y()
		image.save_png("res://screenshots/screenshot_" + str(screenshots) + ".png")
		screenshots += 1
