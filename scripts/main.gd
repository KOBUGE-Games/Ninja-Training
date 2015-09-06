extends Node2D

var block = load("res://scenes/block.xml")
var new_block
var side = 0
var speed = 10
var amount = 0
var last_i = 0

func _ready():
	randomize()
	initial_blocks()
	get_node("gui/replay").hide()
	get_node("StreamPlayer").play()

func _on_Timer_timeout():
	amount = (randi() % 4)+2
	if side == 0:
		for i in range(amount):
			new_block = block.instance()
			new_block.set_pos(Vector2(1086+(i*128),705))
			new_block.get_node("Sprite").set_flip_v(false)
			new_block.speed = speed
			add_child(new_block)
			last_i = i
		side = 1
	else:
		for i in range(amount):
			new_block = block.instance()
			new_block.set_pos(Vector2(1086+(i*128),62))
			new_block.get_node("Sprite").set_flip_v(true)
			new_block.speed = speed
			add_child(new_block)
			last_i = i
		side = 0
		
	if side == 0:
		last_i += 1
		new_block = block.instance()
		new_block.set_pos(Vector2(1086+(last_i*128+64),63))
	
	else:
		last_i += 1
		new_block = block.instance()
		new_block.set_pos(Vector2(1086+(last_i*128+64),704))
	
	new_block.get_node("Sprite").hide()
	new_block.last_one = true
	add_child(new_block)

func _on_replay_pressed():
	get_tree().reload_current_scene()

func _on_Timer_block_timeout():
	speed += 1
	
func initial_blocks():
	for i in range(15):
		new_block = block.instance()
		new_block.set_pos(Vector2(i*128,705))
		new_block.movement = false
		add_child(new_block)