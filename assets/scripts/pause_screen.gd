extends Node2D
@onready var score: Label = $TextureRect/Score
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bg_animation: AnimationPlayer = $"../Menu/MenuBg/AnimationPlayer"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score.text = str(Global.score)


func _on_resume_button_pressed() -> void:
	#Global.pause = false
	animation_player.play("out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "out":
		Global.pause = false


func _on_menu_button_pressed() -> void:
	bg_animation.play("transition_screen_2")
	#bg_animation.queue("inside_screen")
	#Global.pause = false
	#bg_animation.queue("inside_screen")
	Global.gameover = false
	
	Global.floating = true
	Global.score_fadeout = false
	Global.gameover_animation = false
	Global.line_edit_visible = true
	Global.rocket_list = []
	Global.score = 0
	Global.rocket_speed = 50.0
	#menu_transition_animation.play("transition_out")
	#Global.score_fadein = true
	Global.will_show_tutorial = false
	
	await get_tree().create_timer(1.0).timeout
	Global.menu = true
	Global.pause = false
	Global.camera_pos = false
