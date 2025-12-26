extends Node2D
@onready var powerup_music: AudioStreamPlayer2D = $"../../../PowerupMusic"
@onready var bg_music: AudioStreamPlayer2D = $"../../../BgMusic"
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cat_sprite_2d: AnimatedSprite2D = $"../../CatAnimation/Sprite2D"
@onready var cat_white_bg: AnimatedSprite2D = $"../../CatAnimation/Sprite2D/WhiteBg"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.pause:
		return
	if Global.powerup_type == "freeze":
		Global.freeze_timer -= delta
		progress_bar.value = Global.freeze_timer / 20 * 100
		
		if Global.freeze_timer <= 0:
			animation_player.play("out")
			#Global.powerup = false
			#Global.powerup_type = ""
			


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "in":
		bg_music.stop()
		powerup_music.play()
		Global.game_running = true
		Global.rocket_speed /= 2
		Global.player_speed /= 2
		Global.powerup_type = "freeze"
		Global.freeze_timer = 20.0
		cat_sprite_2d.play("freeze")
		cat_white_bg.play("freeze")
	elif anim_name == "out":
		bg_music.play()
		powerup_music.stop()
		Global.powerup = false
		Global.powerup_type = ""
		Global.rocket_speed *= 2
		Global.player_speed *= 2
		cat_sprite_2d.play("default")
		cat_white_bg.play("default")
	##Global.bg_main_music_playing = false
