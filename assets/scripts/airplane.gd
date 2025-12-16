extends Node2D
@onready var spawn_sound: AudioStreamPlayer2D = $SpawnSound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_sound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
