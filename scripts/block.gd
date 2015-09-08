extends KinematicBody2D

var speed = 10
var movement = true
var last_one = false

func _ready():
	set_fixed_process(true)
	set_z(-1)
	
func _fixed_process(delta):
	if movement:
		move(Vector2(-speed,0))
	if get_pos().x < -128:
		queue_free()
		
	if is_colliding():
		if last_one:
			get_parent().get_node("ninja").dead = true
