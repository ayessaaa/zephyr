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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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


func _on_balloon_external_area_area_entered(area: Area2D) -> void:
	player_animation.play("scared")


func _on_balloon_external_area_area_exited(area: Area2D) -> void:
	player_animation.play("default")
