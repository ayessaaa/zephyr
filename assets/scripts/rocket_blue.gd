extends Area2D

@export var pattern = ""
@export var left_or_right = ""
@export var color = "blue"
@export var type = "rocket"
@export var show_score = false
@export var score = 0

@onready var balloon = get_parent().get_parent().get_node("Balloon/CollisionShape2D")
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var letter_pattern: Label = $LetterPattern
@onready var letter_pattern_2: Label = $LetterPattern2
@onready var explosion_sound: AudioStreamPlayer2D = $ExplosionSound
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D

@onready var score_texts: Node2D = get_parent().get_parent().get_node("ScoreTexts")
const SCORE_FLOATING = preload("uid://bhoduwbq1kf51")


func _ready() -> void:
	pattern = Global.patterns_hard[randi_range(0, len(Global.patterns_hard )-1)]
	Global.rocket_list.append(self)
	if left_or_right == 0:
		letter_pattern_2.text = pattern.to_upper()
		sprite_2d.flip_v = true
	else:
		letter_pattern.text = pattern.to_upper()
		
	print("blue")
	

func _process(delta: float) -> void:
	if !Global.game_running or Global.pause:
		return
	if Global.gameover:
		queue_free()
	if show_score:
		var score_floating = SCORE_FLOATING.instantiate()
		score_floating.global_position.x = self.global_position.x - 30
		score_floating.global_position.y = self.global_position.y - 20
		score_floating.score = score
		score_texts.add_child(score_floating)
		show_score = false
	if sprite_2d.animation == "explode":
		letter_pattern.visible = false
		letter_pattern_2.visible = false
		return
	global_position = global_position.move_toward(balloon.global_position, Global.rocket_speed * delta)
	
	var direction = balloon.global_position - global_position
	rotation = direction.angle() + PI
	
	if Global.powerup_type == "freeze":
		sprite_2d.play("freeze")
	else:
		sprite_2d.play("default")


func _on_sprite_2d_animation_finished() -> void:
	queue_free()


func _on_sprite_2d_animation_changed() -> void:
	#pass
	print("changed")
	#explosion_sound.play()
	#collision_polygon_2d.disabled = true
