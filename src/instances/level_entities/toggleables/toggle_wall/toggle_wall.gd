extends TileMap


export(bool) var start_on = true # controls whether the toggleable wall will start on or not
# on = player cannot pass through
# off = player can pass through


func _ready():
	if start_on:
		turn_on()


func turn_on():
	modulate = Color(1, 1, 1, 1)
	set_collision_layer_bit(1, true)


func turn_off():
	modulate = Color(0.25, 0.25, 0.25, 1)
	set_collision_layer_bit(1, false)
