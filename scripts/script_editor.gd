extends Control

@onready var line_editor = $Editor
var mouse_inbound = false 

var valid_keywords = ["if"]
# Dict with objects that can be used and then the valid methods that they can have.
var valid_objects = {"player" : ["walk", "run", "jump"]}
var color = ["black", "red", "blue", "green"]
var variables = [] # Forgot what this is for


func pasrse_line(line):
	var new_line = line.strip_edges(true, true)
	
	# Checking for valid keywords (Only if rn)
	# Going to need to keep track of tabs.
	for keyword in valid_keywords:
		var length = len(keyword)

		# Called the object correctly
		if new_line.substr(0, length) == keyword:
			if keyword == "if":
				var arr = new_line.split()
				
				if arr[1] == "is" and arr[2] == "on" and arr[3] in color:
					return true # Return the color later

	# Checking for method calls on objects.
	for object in valid_objects:
		var obj_length = len(object)

		# Called the object correctly
		if len(new_line) >= obj_length and new_line.substr(0, obj_length) == object  and new_line[len(object)] == '.':
			for method in valid_objects[object]:
				var meth_length = len(method)
				var test = new_line.substr(obj_length + 1, meth_length)
				
				if test == method:
					var arg = new_line.substr(obj_length + 1 + meth_length, 4)
					var num = -2
					
					if len(arg) == 4:
						num = int(float(arg[1] + arg[2]))
					else:
						num = int(float(arg[1]))	


					if arg[0] == '(' and num >= -1 and num <= 1  and arg[-1] == ')':
						return true # Return the method or something
	
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

	for line in code_by_line:
		if not self.pasrse_line(line):
			print(1)
			return i # Ends here because there is an error 
		i += 1

	print(0)
	return 0
	
