extends Node2D

var english_words := {}

@onready var bg_music: AudioStreamPlayer2D = $BgMusic
@onready var score: Area2D = $Score
@onready var menu_buttons: Node2D = $Player/Camera2D/Menu/MenuButtons
@onready var play_button: TextureButton = $Player/Camera2D/Menu/MenuButtons/PlayButton
@onready var style_button: TextureButton = $Player/Camera2D/Menu/MenuButtons/StyleButton
@onready var settings_button: TextureButton = $Player/Camera2D/Menu/MenuButtons/SettingsButton
@onready var score_animation: AnimationPlayer = $Player/Camera2D/Score/ScoreAnimation
@onready var text_input_animation: AnimationPlayer = $Player/TextInput/AnimationPlayer
@onready var text_input: Node2D = $Player/TextInput
@onready var line_edit: LineEdit = $Player/TextInput/LineEdit

const ROCKET_RED = preload("res://assets/scenes/areas/rocket_red.tscn")
const ROCKET_BLUE = preload("res://assets/scenes/areas/rocket_blue.tscn")
const ROCKET_GREEN = preload("res://assets/scenes/areas/rocket_green.tscn")
@onready var rockets: Node = $Rockets

@onready var player: CharacterBody2D = $Player
@onready var meow_1: AudioStreamPlayer2D = $MeowSounds/Meow1
@onready var menu: Node2D = $Player/Camera2D/Menu
@onready var rocket_green: AnimatedSprite2D = $Player/Camera2D/Menu/RocketGreen
@onready var rocket_red: AnimatedSprite2D = $Player/Camera2D/Menu/RocketRed
@onready var rocket_blue: AnimatedSprite2D = $Player/Camera2D/Menu/RocketBlue
@onready var logo: Sprite2D = $Player/Camera2D/Menu/Logo
@onready var subtitle: Sprite2D = $Player/Camera2D/Menu/Subtitle
@onready var menu_bg_animation: AnimationPlayer = $Player/Camera2D/Menu/MenuBg/AnimationPlayer
@onready var gameover: Node2D = $Player/Camera2D/Gameover

var timer = 10
var rocket_position_x = [-500, 500]

var meow_timer = 0


var probability_timer = 0


func _ready():
	#load_word_list("res://words.txt")
	#bg_music.play()
	
	#sound_button()
	var custom_cursor_texture = preload("uid://cj2fdlneamenu")
	var hand_cursor_texture = preload("uid://bapm1li2vjkau")
	Input.set_custom_mouse_cursor(custom_cursor_texture, Input.CURSOR_IBEAM)
	Input.set_custom_mouse_cursor(hand_cursor_texture, Input.CURSOR_POINTING_HAND)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	menu_buttons.visible = Global.menu
	rocket_green.visible = Global.menu
	rocket_red.visible = Global.menu
	rocket_blue.visible = Global.menu
	logo.visible = Global.menu
	subtitle.visible = Global.menu
	gameover.visible = Global.gameover
	if Global.restart:
		Global.restart = false
		get_tree().reload_current_scene()
		return
		
	if !Global.menu and !Global.tutorial and !Global.gameover:
		menu_bg_animation.play("outside_screen")
	#elif Global.menu:
		#menu_bg_animation.play("outside_screen")
		
	#score.visible = !Global.menu and !Global.tutorial
	line_edit.visible = Global.line_edit_visible 
	play_button.disabled = !(Global.menu or Global.tutorial)
	style_button.disabled = !(Global.menu or Global.tutorial)
	settings_button.disabled = !(Global.menu or Global.tutorial)
	
	meow_timer += delta
	if meow_timer >= 5:
		meow_timer = 0
		meow_1.play()
		
	if Global.menu or Global.tutorial:
		return
		
	if Global.gameover:
		bg_music.stop()
	
	timer += delta
	probability_timer += delta*0.25
	
	if timer >= 4:
		timer = 0
		var random_position = randi_range(0, len(rocket_position_x) - 1)
		var random_probability = randi_range(0, 100)
		
		var difficulty_factor = clamp(Global.score / 1000.0, 0.0, 5.0)
		
		var blue_threshold = 10 * difficulty_factor
		var green_threshold = 30 * difficulty_factor
		
		var spawn_pos = Vector2(player.position.x+rocket_position_x[random_position], player.position.y-100)
		
		if random_probability < blue_threshold:
			spawn_rocket(ROCKET_BLUE, spawn_pos, random_position)
		elif random_probability < blue_threshold + green_threshold:
			spawn_rocket(ROCKET_GREEN, spawn_pos, random_position)
		else:
			spawn_rocket(ROCKET_RED, spawn_pos, random_position)
			
	if Global.score_fadein:
		score_animation.play("fade_in")
		text_input_animation.play("fade_in")
		Global.score_fadein = false
		print("run")
	
	
		
func spawn_rocket(rocket_scene, pos, left_or_right):
	var rocket = rocket_scene.instantiate()
	rocket.position = pos
	rocket.left_or_right = left_or_right
	rockets.add_child(rocket)


func _on_bg_music_finished() -> void:
	bg_music.play()
	
func sound_button() -> void:
	var music_bus_index = AudioServer.get_bus_index("Master")
	var current_mute_state = AudioServer.is_bus_mute(music_bus_index)
	AudioServer.set_bus_mute(music_bus_index, not current_mute_state)
