extends Control

signal script_updated(state_space)

@onready var line_editor = $Editor
var mouse_inbound = false 

var valid_keywords = ["if"]
# Dict with objects that can be used and then the valid methods that they can have.
var valid_objects = {"player" : ["walk", "run", "jump"]}
var colors = ["black", "red", "blue", "green"]
var variables = [] # Forgot what this is for

func handle_if(keyword, new_line):
	var length = len(keyword)

	# Called the object correctly
	if new_line.substr(0, length) == keyword:
		if keyword == "if":
			var arr = new_line.split(" ")
			var color = arr[3].replace(":", '')

			if arr[1] == "player" and arr[2] == "on" and color in colors:
				# Now doing the object handling
				for object in valid_objects:
					var ret = handle_object(object, arr[4])
					
					if type_string(typeof(ret)) != "bool":
						# Condition, action, dir
						return [color, ret[1], ret[2]]
	
	return false

func handle_object(object, new_line):
	var obj_length = len(object)

	# Called the object correctly
	if len(new_line) >= obj_length and new_line.substr(0, obj_length) == object  and new_line[len(object)] == '.':
		for method in valid_objects[object]:
			var meth_length = len(method)
			var test = new_line.substr(obj_length + 1, meth_length)
			
			if test == method:
				var arg = new_line.substr(obj_length + 1 + meth_length, 4)
				var num = -2

				if len(arg) < 3:
					break
				
				if len(arg) == 4:
					num = int(float(arg[1] + arg[2]))
				else:
					num = int(float(arg[1]))	


				if arg[0] == '(' and num >= -1 and num <= 1  and arg[-1] == ')':
					# Condition, action, dir
					return [true, method, num]
		
	return false

# An object call should be of the form: "Object.method(arg)" i.e Player.walk(1)
# An if statement should be in the form "if object on color: Object.method(arg)" i.e if player on black: player.walk(1)
func pasrse_line(line):
	var new_line = line.strip_edges(true, true)
	
	# Checking for valid keywords (Only if rn)
	# Going to need to keep track of tabs.
	for keyword in valid_keywords:
		var ret  = handle_if(keyword, new_line)

		if type_string(typeof(ret)) != "bool":
			return ret

	# Checking for method calls on objects.
	for object in valid_objects:
		var ret = handle_object(object, new_line)
		
		if type_string(typeof(ret)) != "bool":
			return ret
	
	return false
					


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	# Cancome bak to this to make it work differently 
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT
		and Input.is_action_just_released("click") and not mouse_inbound):
		line_editor.release_focus() 


func _on_code_edit_mouse_entered():
	mouse_inbound = true


func _on_code_edit_mouse_exited():
	mouse_inbound = false


func _on_button_pressed():
	var code_by_line = line_editor.text.split("\n")
	var i = 0
	var state_space = []

	for line in code_by_line:
		var ret = self.pasrse_line(line)

		if not ret:
			line_editor.set_line(i, line_editor.get_line(i) + " # Incorrect Syntax here")
			line_editor.grab_focus()
			return 
		else:
			state_space.append(ret)

		i += 1

	script_updated.emit(state_space)
		
	
	
