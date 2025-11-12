extends Node2D

var english_words := {}

@onready var bg_music: AudioStreamPlayer2D = $BgMusic

const ROCKET_RED = preload("res://assets/scenes/areas/rocket_red.tscn")
const ROCKET_BLUE = preload("res://assets/scenes/areas/rocket_blue.tscn")
const ROCKET_GREEN = preload("res://assets/scenes/areas/rocket_green.tscn")
@onready var rockets: Node = $Rockets

@onready var player: CharacterBody2D = $Player

var timer = 10
var rocket_position_x = [146.0, 1036.0]

var probability_timer = 0


func _ready():
	#load_word_list("res://words.txt")
	#bg_music.play()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
			
			
	
			
	
		
func spawn_rocket(rocket_scene, pos, left_or_right):
	var rocket = rocket_scene.instantiate()
	rocket.position = pos
	rocket.left_or_right = left_or_right
	rockets.add_child(rocket)


func _on_bg_music_finished() -> void:
	print("ended")
	bg_music.play()
