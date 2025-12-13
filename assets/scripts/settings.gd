extends Node2D

@onready var BG_MUSIC = AudioServer.get_bus_index("BgMusic")
@onready var SFX = AudioServer.get_bus_index("SFX")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX, value)


func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(BG_MUSIC, value)
