extends Node2D

signal next_level

@onready var editor = $ScriptEditor
@onready var player = $Player
@onready var key = $Key
@onready var hazards = $Hazards
@onready var platforms = $Platforms

var player_dead = false

func _advance():
	next_level.emit()

func _update_player_platform_color(color):
	player.update_standing_color(color)

func _kill_player():
	self.player_dead = true
	player.queue_free()

func _add_player_states(state_space):
	if not self.player_dead:
		player.empty_state_space()

		for state in state_space:
			player.add_state(state[0], state[1], state[2])

# Called when the node enters the scene tree for the first time.
func _ready():
	editor.script_updated.connect(_add_player_states)
	key.level_cleared.connect(_advance)

	for hazard in hazards.get_children():
		hazard.kill_player.connect(_kill_player)

	for platform in platforms.get_children():
		platform.colored_platform_entered.connect(_update_player_platform_color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_released("reset") and not editor.get_node("Editor").has_focus():
		self.get_tree().call_deferred("reload_current_scene")

	if Input.is_action_just_released("hide"):
		editor.visible = !(editor.visible)	
