extends CanvasModulate

signal transition_finished(faded_in)
var fade_rate = 0
var fade_amount = 0
var fade_dir = 0
var fading = false


func fade_in(time):
	fade_rate = calculate_fade_rate(time)
	fading = true
	fade_amount = 0
	fade_dir = 0


func fade_out(time):
	fade_rate = calculate_fade_rate(time)
	fading = true
	fade_amount = 0
	fade_dir = 1


func calculate_fade_rate(time):
	 return 1 / time


func _process(delta):
	if fading:
		fade_amount += fade_rate * delta
		if fade_amount >= 1:
			emit_signal("transition_finished", (fade_dir == 0))
			fading = false
			fade_amount = 1
		
		var c = abs(fade_dir - fade_amount)
		color = Color(c, c, c, 1)
