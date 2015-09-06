extends KinematicBody2D

var side = 0
var jump = false
var score = 0

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	
func _fixed_process(delta):
	if !is_colliding():
		jump = false
		if side == 0:
			move(Vector2(0,10))
		else:
			move(Vector2(0,-10))
	else:
		jump = true

func _input(ev):
	if ev.is_pressed() && !ev.is_echo():
		if jump:
			jump = false
			score +=1
			get_parent().get_node("gui/scores").set_text("SCORE: "+str(score))
			if side == 0:
				move(Vector2(0,-10))
				side = 1
				get_node("AnimatedSprite/AnimationPlayer").play("rotate")
				get_node("AnimatedSprite").set_flip_h(true)
			else:
				move(Vector2(0,10))
				side = 0
				get_node("AnimatedSprite/AnimationPlayer").play("rotate")
				get_node("AnimatedSprite").set_flip_h(false)

func _on_VisibilityNotifier2D_exit_viewport( viewport ):
	get_parent().get_node("gui/replay").show()
	get_parent().get_node("gui/scores").set_text("SCORE: "+str(score))
	get_parent().get_node("gui/scores").show()


func _on_AnimationPlayer_finished():
	get_node("AnimatedSprite/AnimationPlayer").play("run")
