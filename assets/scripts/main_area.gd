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

func _ready():
	#load_word_list("res://words.txt")
	#bg_music.play()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer >= 4:
		timer = 0
		var random_int = randi_range(0, len(rocket_position_x)-1)
		spawn_rocket(ROCKET_RED, Vector2(rocket_position_x[random_int], player.position.y), random_int)
	
#func load_word_list(path: String):
	#var file = FileAccess.open(path, FileAccess.READ)
	#if file:
		#while not file.eof_reached():
			#var line = file.get_line().strip_edges()
			#english_words[line.to_lower()] = true
		#file.close()
		
func spawn_rocket(rocket_scene, pos, left_or_right):
	var rocket = rocket_scene.instantiate()
	rocket.position = pos
	rocket.left_or_right = left_or_right
	rockets.add_child(rocket)
