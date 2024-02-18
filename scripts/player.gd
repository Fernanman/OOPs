extends CharacterBody2D

const WALK_SPEED = 100
const RUN_SPEED = 300
const JUMP_VELOCITY = -150
const GRAVITY = 250 #ProjectSettings.get_setting("physics/2d/default_gravity")

var current_state = "Idle"
var dir = 0
var state_space = []

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D

func add_state(condtion, action, dir):
	state_space.append([condtion, action, dir])

func pop_state():
	state_space.pop_back()

# States work on a stack assigning states in FILO order.
func transition_state():
	for state in state_space:
		if state[0]:
			current_state = state[1]
			dir = state[2]

func _process(delta):
	self.transition_state()
	
	print(current_state)

func _ready():
	self.add_state(true, "Walk", 1)

func _physics_process(delta):
	# Falling
	if not self.is_on_floor():
		velocity.y += GRAVITY * delta
	
	# Walk
	if current_state == "Walk":
		if dir == 1:
			sprite.flip_h = false
		elif dir == -1:
			sprite.flip_h = true

		velocity.x = dir * WALK_SPEED

		if self.is_on_floor():
			animation.play("Walk")
	# Jump
	elif current_state == "Idle":
		self.velocity.x = move_toward(velocity.x, 0, WALK_SPEED / 2)

		if self.is_on_floor():
			animation.play("Idle")

	# Jump
	if current_state == "Jump" and is_on_floor():
		animation.play("Jump")
		velocity.y = JUMP_VELOCITY

	self.move_and_slide()
