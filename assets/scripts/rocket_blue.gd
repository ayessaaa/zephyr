extends Area2D

@export var pattern = ""
@export var left_or_right = ""
@export var color = "blue"
@export var type = "rocket"

@onready var balloon = get_parent().get_parent().get_node("Balloon/CollisionShape2D")
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var letter_pattern: Label = $LetterPattern
@onready var letter_pattern_2: Label = $LetterPattern2
@onready var explosion_sound: AudioStreamPlayer2D = $ExplosionSound
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D


func _ready() -> void:
	pattern = Global.patterns_hard[randi_range(0, len(Global.patterns_hard )-1)]
	Global.rocket_list.append(self)
	if left_or_right == 0:
		letter_pattern_2.text = pattern.to_upper()
		sprite_2d.flip_v = true
	else:
		letter_pattern.text = pattern.to_upper()
	

func _process(delta: float) -> void:
	if sprite_2d.animation == "explode":
		letter_pattern.visible = false
		letter_pattern_2.visible = false
		return
	global_position = global_position.move_toward(balloon.global_position, Global.rocket_speed * delta)
	
	var direction = balloon.global_position - global_position
	rotation = direction.angle() + PI


func _on_sprite_2d_animation_finished() -> void:
	queue_free()


func _on_sprite_2d_animation_changed() -> void:
	explosion_sound.play()
	collision_polygon_2d.disabled = true
