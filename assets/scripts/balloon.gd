extends RigidBody2D

@onready var player_animation: AnimatedSprite2D = $"../Player/CatAnimation/Sprite2D"
@onready var rope_2: RigidBody2D = $"../Rope2"
@onready var rope_3: RigidBody2D = $"../Rope3"
@onready var rope_4: RigidBody2D = $"../Rope4"
@onready var rope_5: RigidBody2D = $"../Rope5"
@onready var player: CharacterBody2D = $"../Player"
@onready var balloon_pop_sound: AudioStreamPlayer2D = $BalloonPopSound
@onready var white_bg: AnimatedSprite2D = $WhiteBg
@onready var balloon_sprite_2d: AnimatedSprite2D = $BalloonSprite2D
@onready var unshield_sound: AudioStreamPlayer2D = $"../Player/Camera2D/PowerupScreen/UnshieldSound"
@onready var powerup_animation: AnimationPlayer = $"../Player/Camera2D/PowerupScreen/AnimationPlayer"
@onready var shield: AnimatedSprite2D = $Shield
@onready var shield_animation_player: AnimationPlayer = $Shield/AnimationPlayer
@onready var explosion_sound: AudioStreamPlayer2D = $"../ExplosionSound"

var shield_fade_in = false
var explode = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.powerup_type == "shield" and !shield_fade_in:
		shield_animation_player.play("fade_in")
		shield_fade_in = true
		
	if !explode:
		balloon_sprite_2d.play(Global.balloon+"_"+Global.balloon_color)
		white_bg.play(Global.balloon)

func _on_balloon_area_area_entered(area: Area2D) -> void:
	if area.type == "rocket":
		
		Global.rocket_list.erase(area)
		area.get_node("Sprite2D").play("explode")
		
		rope_2.visible = false
		rope_3.visible = false
		rope_4.visible = false
		rope_5.visible = false
		
		Global.floating = false
		Global.score_fadeout = true
		Global.gameover = true
		Global.gameover_animation = true
		balloon_pop_sound.play()
		white_bg.play("explode")
		balloon_sprite_2d.play("explode")
		explode = true


func _on_balloon_external_area_area_entered(area: Area2D) -> void:
	if Global.powerup_type != "shield":
		player_animation.play("scared")
	elif Global.powerup_type == "shield":
		Global.rocket_list.erase(area)
		area.get_node("Sprite2D").play("explode")
		Global.powerup_type = ""
		unshield_sound.play()
		powerup_animation.play("out")
		shield_animation_player.play("fade_out")
		explosion_sound.play()
		return


func _on_balloon_external_area_area_exited(area: Area2D) -> void:
	player_animation.play("default")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		shield_fade_in = false
