extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= 30 * delta
	
	if Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right"):
		position.x -= .4
	elif Input.is_action_pressed("ui_right") and !Input.is_action_pressed("ui_left"):
		position.x += .4
