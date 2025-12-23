extends Node2D
@onready var powerup_music: AudioStreamPlayer2D = $PowerupMusic
@onready var bg_music: AudioStreamPlayer2D = $"../../../BgMusic"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	bg_music.stop()
	powerup_music.play()
	##Global.bg_main_music_playing = false
