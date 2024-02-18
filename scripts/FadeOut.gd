extends CanvasLayer

signal animation_finished

func transition():
	self.visible = true
	$AnimationPlayer.play("fade_out")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fade_in")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out":
		animation_finished.emit()
		$AnimationPlayer.play("fade_in")
	elif anim_name == "fade_in":
		self.visible = false
