extends KinematicBody2D

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	move(Vector2(-10,0))
	if is_colliding():
		print(get_collider().get_name())