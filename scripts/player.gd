extends CharacterBody2D

const WALK_SPEED = 100
const RUN_SPEED = 150
const JUMP_VELOCITY = -150
const GRAVITY = 250 #ProjectSettings.get_setting("physics/2d/default_gravity")

var current_state = "idle"
var dir = 0
var state_space = []
var color_standing_on = "black"  # Saying that black is the degfault

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D

func update_standing_color(color):
	self.color_standing_on = color

func empty_state_space():
	self.state_space = []

func add_state(condtion, action, dir):
	state_space.append([condtion, action, dir])

func pop_state():
	state_space.pop_back()

# States work on a stack assigning states in FILO order.
func transition_state():
	for state in state_space:
		var condition = false

		if type_string(typeof(state[0])) == "String":
			condition = color_standing_on == state[0]
		else:
			condition = state[0]

		if condition:
			current_state = state[1]
			dir = state[2]
			

func _process(delta):
	self.transition_state()
	# print(color_standing_on)
	# print(self.state_space)
	# print(animation.get_current_animation())
	# print(current_state)

func _ready():
	# self.add_state(true, "walk", 1)
	pass

func _physics_process(delta):
	# Falling
	if not self.is_on_floor():
		velocity.y += GRAVITY * delta
	
	# walk
	if current_state == "walk":
		if dir == 1:
			sprite.flip_h = false
		elif dir == -1:
			sprite.flip_h = true

		velocity.x = dir * WALK_SPEED

		if self.is_on_floor():
			animation.play("Walk")
	elif current_state == "run":
		if dir == 1:
			sprite.flip_h = false
		elif dir == -1:
			sprite.flip_h = true

		velocity.x = dir * RUN_SPEED

		if self.is_on_floor():
			animation.play("Run")
	# jump
	elif current_state == "idle":
		self.velocity.x = move_toward(velocity.x, 0, WALK_SPEED / 2)

		if self.is_on_floor():
			animation.play("Idle")

	# jump
	if current_state == "jump" and is_on_floor():
		animation.play("Jump")
		velocity.y = JUMP_VELOCITY

	self.move_and_slide()
