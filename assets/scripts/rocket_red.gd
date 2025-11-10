extends Area2D

@onready var balloon = get_parent().get_parent().get_node("Balloon/CollisionShape2D")

const SPEED = 50.0

func _process(delta: float) -> void:
	global_position = global_position.move_toward(balloon.global_position, SPEED * delta)
	
	var direction = balloon.global_position - global_position
	rotation = direction.angle() + PI
