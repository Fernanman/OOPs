extends Control

@onready var line_editor = $CenterContainer/LineEdit
var mouse_inbound = false 

var valid_keywords = []
var variables = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	# Cancome bak to this to make it work differently 
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT
		and Input.is_action_just_released("click") and not mouse_inbound):
		line_editor.release_focus()


func _on_line_edit_text_submitted(new_text):
	print(line_editor.text)


func _on_line_edit_mouse_entered():
	mouse_inbound = true	

func _on_line_edit_mouse_exited():
	mouse_inbound = false
