extends StaticBody2D

signal colored_platform_entered(color)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Animation.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		colored_platform_entered.emit("blue")
