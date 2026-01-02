extends Node2D
@onready var powerup_music: AudioStreamPlayer2D = $"../../../PowerupMusic"
@onready var bg_music: AudioStreamPlayer2D = $"../../../BgMusic"
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cat_sprite_2d: AnimatedSprite2D = $"../../CatAnimation/Sprite2D"
@onready var cat_white_bg: AnimatedSprite2D = $"../../CatAnimation/Sprite2D/WhiteBg"
@onready var top_right: AnimatedSprite2D = $TopRight
@onready var bottom_left: AnimatedSprite2D = $BottomLeft
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var timer_bg: AnimatedSprite2D = $TimerBg
@onready var progress_animation_player: AnimationPlayer = $ProgressBar/AnimationPlayer

@onready var white_bg: AnimatedSprite2D = $"../../../Balloon/WhiteBg"
@onready var balloon_sprite_2d: AnimatedSprite2D = $"../../../Balloon/BalloonSprite2D"
@onready var snow_balloon: AnimatedSprite2D = $"../../../Balloon/SnowBalloon"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.pause:
		return
		
		
	if Global.powerup_type == "freeze":
		top_right.play("freeze")
		bottom_left.play("freeze")
		sprite_2d.play("freeze")
		timer_bg.play("freeze")
		progress_animation_player.play("freeze")
		white_bg.play(Global.balloon+"_freeze")
		snow_balloon.play(Global.balloon)
		#balloon_sprite_2d.play(Global.balloon+"_freeze")
		
		if Global.game_running:
			Global.freeze_timer -= delta
			progress_bar.value = Global.freeze_timer / 20 * 100
			
			if Global.freeze_timer <= 0:
				animation_player.play("out")
				snow_balloon.play("none")
				
	elif Global.powerup_type == "double":
		top_right.play("double")
		bottom_left.play("double")
		sprite_2d.play(Global.cat+"_double")
		timer_bg.play("double")
		progress_animation_player.play("double")
		
		if Global.game_running:
			Global.double_timer -= delta
			progress_bar.value = Global.double_timer / 15 * 100
			
			if Global.double_timer <= 0:
				animation_player.play("out")
				
	elif Global.powerup_type == "shield":
		top_right.play("shield")
		bottom_left.play("shield")
		sprite_2d.play(Global.cat+"_shield")
		timer_bg.play("shield")
		progress_animation_player.play("shield")
		
		if Global.game_running:
			Global.shield_timer -= delta
			progress_bar.value = Global.shield_timer / 100 * 100
			
			if Global.shield_timer <= 0:
				animation_player.play("out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "freeze_in":
		bg_music.stop()
		powerup_music.play()
		Global.game_running = true
		Global.rocket_speed /= 2
		Global.player_speed /= 2
		#Global.powerup_type = "freeze"
		Global.freeze_timer = 20.0
		cat_sprite_2d.play(Global.cat+"_freeze")
		cat_white_bg.play("freeze")
	elif anim_name == "double_in":
		bg_music.stop()
		powerup_music.play()
		Global.game_running = true
		Global.double_timer = 15.0
	elif anim_name == "shield_in":
		bg_music.stop()
		powerup_music.play()
		Global.game_running = true
		Global.shield_timer = 100.0
		cat_sprite_2d.play(Global.cat+"_shield")
		cat_white_bg.play("shield")
	elif anim_name == "out":
		if Global.powerup_type == "freeze":
			Global.rocket_speed *= 2
			Global.player_speed *= 2
		bg_music.play()
		powerup_music.stop()
		Global.powerup = false
		Global.powerup_type = ""
		
		cat_sprite_2d.play(Global.cat+"_default")
		cat_white_bg.play("default")
		
	##Global.bg_main_music_playing = false
