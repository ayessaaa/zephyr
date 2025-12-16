extends PathFollow2D
@onready var dashes: Node2D = $"../Dashes"
@onready var DASH = preload("uid://ds40g3tirdeha")
var speed = .075
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#var dash_timer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio += delta * speed
	#dash_timer += delta
	#if dash_timer > 2:
		#dash_timer = 0
		#var dash = DASH.instantiate()
		#dash.global_position = animated_sprite_2d.global_position
		#dash.rotation = animated_sprite_2d.rotation
		#dashes.add_child(dash)
