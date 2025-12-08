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

var hovering = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score.text = str(Global.score)
	best_score_text.text = "best score: "+str(Global.best_score)
	if Global.gameover_animation:
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
