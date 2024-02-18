extends Node2D

@onready var level = $CurrentScene
@onready var fade = $Fade
var current_level_num = 0

var level_array = [preload("res://scenes/Levels/level_2.tscn"),
				   preload("res://scenes/Levels/level_3.tscn"),
				   preload("res://scenes/Levels/level_4.tscn"),
				   preload("res://scenes/Levels/level_5.tscn"),
				   preload("res://scenes/Levels/level_6.tscn"),
				   preload("res://scenes/Levels/level_7.tscn"),
				   preload("res://scenes/Levels/end.tscn")
				   ]

func _queue_fade():
	print('x')
	fade.transition()


# Called when the node enters the scene tree for the first time.
func _ready():
	level.get_child(0).next_level.connect(_queue_fade)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_fade_animation_finished():
	level.get_child(0).queue_free()
	level.add_child(level_array[self.current_level_num].instantiate())
	
	if current_level_num < 6:
		level.get_child(1).next_level.connect(_queue_fade)
		
	current_level_num += 1	
	
