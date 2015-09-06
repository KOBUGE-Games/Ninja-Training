extends KinematicBody2D

var speed = 10
var movement = true

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	set_z(-1)
	
func _fixed_process(delta):
	if movement:
		move(Vector2(-speed,0))
	if get_pos().x < -128:
		queue_free()
		
func _input(ev):
	if ev.is_pressed() && !ev.is_echo():
		movement = true