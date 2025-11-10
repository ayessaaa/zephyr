extends Area2D

@onready var balloon = get_parent().get_parent().get_node("Balloon/CollisionShape2D")

const SPEED = 100.0

func _process(delta: float) -> void:
	global_position = global_position.move_toward(balloon.global_position, SPEED * delta)
	
	# Move toward target
	
	var direction = balloon.global_position - global_position
	rotation = direction.angle() + PI
