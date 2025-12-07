extends Node2D

var english_words := {}

@onready var bg_music: AudioStreamPlayer2D = $Player/BgMusic
@onready var score: Area2D = $Score
@onready var menu_buttons: Node2D = $Player/Camera2D/Menu/MenuButtons
@onready var play_button: TextureButton = $Player/Camera2D/Menu/MenuButtons/PlayButton
@onready var style_button: TextureButton = $Player/Camera2D/Menu/MenuButtons/StyleButton
@onready var settings_button: TextureButton = $Player/Camera2D/Menu/MenuButtons/SettingsButton

const ROCKET_RED = preload("res://assets/scenes/areas/rocket_red.tscn")
const ROCKET_BLUE = preload("res://assets/scenes/areas/rocket_blue.tscn")
const ROCKET_GREEN = preload("res://assets/scenes/areas/rocket_green.tscn")
@onready var rockets: Node = $Rockets

@onready var player: CharacterBody2D = $Player
@onready var meow_1: AudioStreamPlayer2D = $MeowSounds/Meow1

var timer = 10
var rocket_position_x = [146.0, 1036.0]

var meow_timer = 0


var probability_timer = 0


func _ready():
	#load_word_list("res://words.txt")
	#bg_music.play()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score.visible = !Global.menu and !Global.tutorial
	play_button.disabled = !(Global.menu or Global.tutorial)
	style_button.disabled = !(Global.menu or Global.tutorial)
	settings_button.disabled = !(Global.menu or Global.tutorial)
	if Global.menu or Global.tutorial:
		return
	timer += delta
	probability_timer += delta*0.25
	
	if timer >= 4:
		timer = 0
		var random_position = randi_range(0, len(rocket_position_x) - 1)
		var random_probability = randi_range(0, 100)
		
		var difficulty_factor = clamp(Global.score / 1000.0, 0.0, 5.0)
		
		var blue_threshold = 10 * difficulty_factor
		var green_threshold = 30 * difficulty_factor
		
		var spawn_pos = Vector2(rocket_position_x[random_position], player.position.y-100)
		
		if random_probability < blue_threshold:
			spawn_rocket(ROCKET_BLUE, spawn_pos, random_position)
		elif random_probability < blue_threshold + green_threshold:
			spawn_rocket(ROCKET_GREEN, spawn_pos, random_position)
		else:
			spawn_rocket(ROCKET_RED, spawn_pos, random_position)
			
			
	meow_timer += delta
	if meow_timer >= 5:
		meow_timer = 0
		meow_1.play()
	
		
func spawn_rocket(rocket_scene, pos, left_or_right):
	var rocket = rocket_scene.instantiate()
	rocket.position = pos
	rocket.left_or_right = left_or_right
	rockets.add_child(rocket)
