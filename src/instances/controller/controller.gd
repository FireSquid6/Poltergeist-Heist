extends Node2D


onready var player_list = []
onready var player_selected = 0
onready var indicator = get_node("Indicator")

func _ready():
	# get all children
	var children = get_children()
	for child in children:
		if child != indicator:
			player_list.append(child)
	
	# switch to the first player
	switch_player(0)

func switch_player(new_index):
	new_index = clamp(new_index, 0, len(player_list) - 1)
