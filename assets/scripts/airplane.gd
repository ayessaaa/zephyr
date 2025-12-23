extends Node2D
@onready var spawn_sound: AudioStreamPlayer2D = $SpawnSound
@onready var collect_sound: AudioStreamPlayer2D = $CollectSound
@onready var animated_sprite_2d: AnimatedSprite2D = $Path2D/PathFollow2D/AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $Path2D/PathFollow2D/AnimatedSprite2D/AnimationPlayer
@onready var powerup_screen_animation: AnimationPlayer = get_parent().get_parent().get_node("PowerupScreen/AnimationPlayer")

var sprite_float = false

@export var letter_sequences = [
	"ence", 
	"ance", 
	"ible", 
	"able", 
	"ptio", 
	"ctio",  
	"ough", 
	"eigh", 
	"augh", 
]

var letter_sequence = ""
@onready var letters: Label = $Path2D/PathFollow2D/AnimatedSprite2D/Letters

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_sound.play()
	var random_x = randi_range(0, len(letter_sequences)-1)
	letter_sequence = letter_sequences[random_x]
	letters.text = letter_sequence.to_upper()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if sprite_float:
		animated_sprite_2d.position.y += 2


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "disappear":
		#queue_free()
		animated_sprite_2d.play("snow")
		animation_player.play("disappear")
		sprite_float = true
		Global.game_running = false
		powerup_screen_animation.play("in")
		

#
#func _on_animated_sprite_2d_animation_changed() -> void:
	#print(animated_sprite_2d.animation)
	#if animated_sprite_2d.animation == "disappear":
		#print("schanged")
		#collect_sound.play()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
