extends Node2D
@onready var spawn_sound: AudioStreamPlayer2D = $SpawnSound

@export var letter_sequences = [
	"ence", 
	"ance", 
	"ible", 
	"able", 
	"ptio", 
	"ctio",  
	"ough", 
	"eigh", 
	"augh", 
]

var letter_sequence = ""
@onready var letters: Label = $Path2D/PathFollow2D/AnimatedSprite2D/Letters

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_sound.play()
	var random_x = randi_range(0, len(letter_sequences)-1)
	letter_sequence = letter_sequences[random_x]
	letters.text = letter_sequence.to_upper()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
