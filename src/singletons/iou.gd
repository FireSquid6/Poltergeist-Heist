extends TextureRect


var link = "https://youtu.be/dQw4w9WgXcQ"
onready var mouse_over = false


func _process(delta):
	if Input.is_action_just_pressed("mouse_left"):
		OS.shell_open(link)


func _on_Iou_mouse_entered():
	mouse_over = true


func _on_Iou_mouse_exited():
	mouse_over = false
