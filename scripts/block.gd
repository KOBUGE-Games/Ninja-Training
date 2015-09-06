extends KinematicBody2D

var speed = 10

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	move(Vector2(-speed,0))
	if get_pos().x < -640:
		queue_free()