extends Node2D

var block = load("res://scenes/block.xml")
var new_block
var side = 0
var speed = 10

func _ready():
	randomize()
	get_node("gui/replay").hide()

func _on_Timer_timeout():
	new_block = block.instance()
	side = randi() % 2
	if side == 0:
		new_block.set_pos(Vector2(1344,705))
		new_block.get_node("Sprite").set_flip_v(false)
	else:
		new_block.set_pos(Vector2(1344,62))
		new_block.get_node("Sprite").set_flip_v(true)
	
	new_block.speed = speed
	add_child(new_block)

func _on_replay_pressed():
	get_tree().reload_current_scene()

func _on_Timer_block_timeout():
	speed += 1