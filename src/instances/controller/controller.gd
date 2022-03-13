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
	# deactivate all players
	for player in player_list:
		player.state = player.STATES.IDLE
	
	# activate the new player
	new_index = clamp(new_index, 0, len(player_list) - 1)
	player_list[player_selected].state = player_list[player_selected].STATES.CONTROLLED


func _process(delta):
	# if the input to switch the player is recieved
	if Input.is_action_just_pressed("plr_switch"):
		# update player_selected
		player_selected += 1
		if player_selected > len(player_list) - 1:
			player_selected = 0
		
		# tell the player to start moving
		switch_player(player_selected)
		
		
