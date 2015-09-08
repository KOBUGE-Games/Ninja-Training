extends Node2D

var block = load("res://scenes/block.xml")
var new_block
var side = 1
var speed = 10
var amount = 0
var last_i = 0
var last_block

func _ready():
	randomize()
	initial_blocks()
	get_node("gui/replay").hide()
	get_node("StreamPlayer").play()

func _on_Timer_timeout():
	amount = (randi() % 5)+2
	if side == 0:
		for i in range(amount):
			new_block = block.instance()
			new_block.set_pos(Vector2(1344+(i*128),704))
			new_block.get_node("Sprite").set_flip_v(false)
			new_block.speed = speed
			new_block.add_collision_exception_with(last_block)
			last_block = new_block
			add_child(new_block)
			last_i = i
		side = 1
	else:
		for i in range(amount):
			new_block = block.instance()
			new_block.set_pos(Vector2(1344+(i*128),16))
			new_block.get_node("Sprite").set_flip_v(true)
			new_block.speed = speed
			new_block.add_collision_exception_with(last_block)
			last_block = new_block
			add_child(new_block)
			last_i = i
		side = 0

func _on_replay_pressed():
	get_tree().reload_current_scene()

func _on_Timer_block_timeout():
	speed += 1
	
func initial_blocks():
	for i in range(15):
		new_block = block.instance()
		new_block.set_pos(Vector2(i*128+1,705))
		if last_block != null:
			new_block.add_collision_exception_with(last_block)
		last_block = new_block
		new_block.movement = false
		new_block.add_to_group("init_blocks")
		add_child(new_block)