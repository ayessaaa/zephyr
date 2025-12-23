extends Node2D
@onready var play_button: TextureButton = $PlayButton
@onready var style_button: TextureButton = $StyleButton
@onready var settings_button: TextureButton = $SettingsButton
@onready var hover_music: AudioStreamPlayer2D = $HoverMusic
@onready var animation_player: AnimationPlayer = $"../MenuBg/AnimationPlayer"
@onready var select_music: AudioStreamPlayer2D = $SelectMusic
@onready var tutorial_animation: AnimationPlayer = $"../Tutorial/AnimationPlayer"

var hovering = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.menu and !Global.tutorial:
		if play_button.is_hovered() and hovering != "play":
			hover_music.play()
			hovering = "play"
			Global.line_edit_visible = true
		elif style_button.is_hovered() and hovering != "style":
			hover_music.play()
			hovering = "style"
		elif settings_button.is_hovered() and hovering != "settings":
			hover_music.play()
			hovering = "settings"
		if !play_button.is_hovered() and !style_button.is_hovered() and !settings_button.is_hovered():
			hovering = ""
		


func _on_play_button_pressed() -> void:
	#Global.menu = false
	#if Global.menu:
	if Global.will_show_tutorial:
		animation_player.queue("transition")
		select_music.play()
		tutorial_animation.play("fade_in")
		Global.tutorial = true
		await get_tree().create_timer(1.0).timeout
		Global.menu = false
	else:
		animation_player.queue("transition_screen")
		select_music.play()
		#Global.menu = false
		print("transition")
		Global.playing = true
			


#func _on_style_button_pressed() -> void:
	#if Global.menu:
		#animation_player.play("transition_out")


func _on_settings_button_pressed() -> void:
	#if Global.will_show_tutorial:
	animation_player.queue("transition")
	select_music.play()
	#tutorial_animation.play("fade_in")
	Global.settings = true
	#else:
		#animation_player.queue("transition_screen")
		#select_music.play()
		##Global.menu = false
		#print("transition")
