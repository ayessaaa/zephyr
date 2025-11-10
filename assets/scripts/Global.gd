extends Node

var english_words := {}

func _ready():
	load_word_list("res://words.txt")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func load_word_list(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		while not file.eof_reached():
			var line = file.get_line().strip_edges()
			english_words[line.to_lower()] = true
		file.close()

var menu = true
