extends CharacterBody2D

const WALK_SPEED = 150
const RUN_SPEED = 300
const JUMP_VELOCITY = -150
const GRAVITY = 200 #ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D

func _process(delta):
	print(animation.get_current_animation())
	print(jump_count)

func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")

	if not self.is_on_floor():
		jump_count += 1
		velocity.y += GRAVITY * delta
	
	if direction:
		if direction == 1:
			sprite.flip_h = false
		else:
			sprite.flip_h = true

		velocity.x = direction * WALK_SPEED

		if self.is_on_floor():
			animation.play("Walk")
	else:
		self.velocity.x = move_toward(velocity.x, 0, WALK_SPEED / 2)

		if self.is_on_floor():
			animation.play("Idle")


	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump_count += 1
		animation.play("Jump")
		velocity.y = JUMP_VELOCITY

	if animation.get_current_animation() == "Jump" and self.is_on_floor() and jump_count > 10:
		jump_count = 0
		animation.play("Land")

	self.move_and_slide()
