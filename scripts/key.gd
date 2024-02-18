extends Area2D

signal level_cleared

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Pulse")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		level_cleared.emit()
