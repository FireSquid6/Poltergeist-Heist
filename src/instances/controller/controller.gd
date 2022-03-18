extends Node2D


onready var player_list = []
onready var player_selected = 0
onready var audio = get_node("Audio")
onready var combined = false
onready var combined_obj = null

var combined_scene = preload("res://instances/players/combined/combined.tscn")

func _ready():
	# get all children
	var children = get_children()
	for child in children:
		if child != audio:
			player_list.append(child)
	
	# switch to the first player
	switch_player(0)

func switch_player(new_index):
	# make all players idle
	for player in player_list:
		player.state = player.STATES.IDLE
	
	# activate the new player
	new_index = clamp(new_index, 0, len(player_list) - 1)
	player_list[player_selected].state = player_list[player_selected].STATES.CONTROLLED


func split():
	$Audio/Combine.play()
	
	# move other players to combined
	var dir = 1
	for player in player_list:
		player.position = Vector2(combined_obj.position.x + (-32 * dir), combined_obj.position.y)
		player.state = player.STATES.IDLE
		dir *= 0
	
	# set the active player to control
	player_list[player_selected].state = player_list[player_selected].STATES.CONTROLLED
	
	# destroy combined obj
	combined_obj.queue_free()


func combine(combine_to):
	$Audio/Combine.play()
	
	# deactivate all players
	for player in player_list:
		player.state = player.STATES.COMBINED
	
	# spawn the combined object
	combined_obj = combined_scene.instance()
	add_child(combined_obj)
	
	# move it to the correct position
	combined_obj.position = combine_to
	combined_obj.state = combined_obj.STATES.CONTROLLED


func _process(delta):
	# if the input to switch the player is recieved
	if Input.is_action_just_pressed("plr_switch") and !combined:
		# update player_selected
		player_selected += 1
		if player_selected > len(player_list) - 1:
			player_selected = 0
		
		# tell the player to start moving
		switch_player(player_selected)
	
	# if the input to combine players is received
	if Input.is_action_just_pressed("plr_merge"):
		combined = !combined
		if combined:
			combine(player_list[player_selected].position + player_list[player_selected].get_node("MergePosition").position)
		else:
			split()
	
	# update globals
	Global.players_combined = combined
