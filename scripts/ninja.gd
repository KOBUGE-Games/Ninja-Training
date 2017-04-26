extends KinematicBody2D

var conf = "user://config.cfg" 
var side = 0
var jump = false
var score = 0
var sound = 0
var start = false
var dead = false
var hit = false

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	get_parent().get_node("gui/scores").set_text("HIGHSCORE: "+str(get_previous_score()))
	get_node("AnimatedSprite/AnimationPlayer").play("idle")


func _fixed_process(delta):
	if !dead:
		if !get_node("ray_bottom").is_colliding() && !get_node("ray_up").is_colliding():
			jump = false
			if side == 0:
				move(Vector2(0,22))
			else:
				move(Vector2(0,-22))
		else:
			jump = true

	else:
		if side == 0:
			move(Vector2(0,22))
		else:
			move(Vector2(0,-22))
	
	if get_node("RayCast2D").is_colliding():
		add_collision_exception_with(get_node("RayCast2D").get_collider())
		hit = true
		
	if hit:
		if side == 0:
			move(Vector2(-int(get_node("RayCast2D").get_collider().speed),22))
		else:
			move(Vector2(-int(get_node("RayCast2D").get_collider().speed),-22))
		hit = false

func _input(ev):
	if ev.is_pressed() && !ev.is_echo() && jump && start:
		jump = false
		sound = (randi() % 3)+1
		get_node("SamplePlayer").play("swing"+str(sound))
		score +=1
		get_parent().get_node("gui/scores").set_text("SCORE: "+str(score))
		if side == 0:
			move(Vector2(0,-50))
			get_node("AnimatedSprite/AnimationPlayer").play("rotate")
			get_node("AnimatedSprite").set_flip_h(true)
			side = 1
		else:
			move(Vector2(0,50))
			get_node("AnimatedSprite/AnimationPlayer").play("rotate",-1,-1,true)
			get_node("AnimatedSprite").set_flip_h(false)
			side = 0

func _on_VisibilityNotifier2D_exit_viewport( viewport ):
	get_parent().get_node("gui/replay").show()
	get_parent().get_node("gui/scores").hide()
	get_parent().get_node("gui/welcome").set_text("GAME OVER\n SCORE: "+str(score))
	get_parent().get_node("gui/welcome").show()
	if score > get_previous_score():
		highscore(score)


func _on_AnimationPlayer_finished():
	get_node("AnimatedSprite/AnimationPlayer").play("run")


func _on_start_pressed():
	randomize()
	get_parent().get_node("StreamPlayer").play()
	get_node("SamplePlayer").play("begin")
	get_parent().get_node("Timer").start()
	get_parent().get_node("gui/welcome").hide()
	get_node("AnimatedSprite/AnimationPlayer").play("run")
	for block in get_tree().get_nodes_in_group("init_blocks"):
		block.movement = true
	start = true
	get_parent().get_node("gui/start").queue_free()
	get_parent().get_node("gui/scores").set_text("SCORE: 0")
	
func highscore(score):
	var f = ConfigFile.new()
	f.load(conf)
	f.set_value("game","score", score)
	f.save(conf)

func get_previous_score():
	var f = ConfigFile.new()
	f.load(conf)
	if f.has_section("game"):
		return int(f.get_value("game","score"))
	else:
		return 0
