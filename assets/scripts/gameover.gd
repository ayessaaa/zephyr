extends Node2D
@onready var bg_animation: AnimationPlayer = get_parent().get_node("Menu/MenuBg/AnimationPlayer")
@onready var gameover_sound: AudioStreamPlayer2D = $GameoverSound
@onready var hover_music: AudioStreamPlayer2D = $HoverMusic
@onready var select_music: AudioStreamPlayer2D = $SelectMusic
@onready var play_again: TextureButton = $PlayAgain
@onready var main_menu: TextureButton = $MainMenu
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var score: Label = $TextureRect/Score
@onready var best_score_text: Label = $BestScoreText
@onready var hide_animation: AnimationPlayer = $"../Menu/HideAnimation"

var hovering = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score.text = str(Global.score)
	best_score_text.text = "best score: "+str(Global.best_score)
	if Global.gameover_animation:
		if Global.best_score < Global.score:
			Global.best_score = Global.score
		print("dead")
		bg_animation.play("in")
		Global.gameover_animation = false
		gameover_sound.play()
		await get_tree().create_timer(2.0).timeout 
		animation_player.play("fade_in")
		
	if Global.gameover:
		if play_again.is_hovered() and hovering != "play_again":
			hover_music.play()
			hovering = "play_again"
		elif main_menu.is_hovered() and hovering != "main_menu":
			hover_music.play()
			hovering = "main_menu"
		if !play_again.is_hovered() and !main_menu.is_hovered():
			hovering = ""


func _on_play_again_pressed() -> void:
	animation_player.play("fade_out")
	#bg_animation.play("out")
	#Global.gameover = false
	#Global.restart = true
	#Global.floating = true
	#Global.score_fadeout = false
	#Global.gameover_animation = false
	#Global.line_edit_visible = true
	#Global.rocket_list = []
	#Global.score = 0
	#Global.rocket_speed = 50.0
	##menu_transition_animation.play("transition_out")
	#Global.score_fadein = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		bg_animation.play("out")
