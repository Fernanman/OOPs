extends StaticBody2D

@onready var collision_hitbox = $Collision
@onready var detection = $Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	collision_hitbox.set_deferred("disabled", true)
	$AnimationPlayer.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for body in detection.get_overlapping_bodies():

		if body.get_class() == "CharacterBody2D" and body.current_state == "run":
			collision_hitbox.set_deferred("disabled", true)
		else:
			collision_hitbox.set_deferred("disabled", false)



# func _on_area_2d_body_entered(body):
# 	if body.get_class() == "CharacterBody2D":
# 		if body.current_state == "run":
# 			collision_hitbox.set_deferred("disabled", true)
# 		else:
# 			collision_hitbox.set_deferred("disabled", false)


