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

var patterns_easy = ["an", "in", "on", "at", "it", "en", "er", "ar", "or", "us", "um", "is",
					"th", "sh", "ch", "ph", "st", "tr", "br", "cl", "pr", "dr", "gr", "bl",
					"ed", "es", "ly", "er", "al", "le", "nt", "nd", "ck", "ng",
					"gh", "pt", "wr", "kn", "qu", "xi"]
var patterns_medium = ["ing", "str", "pre", "ous", "ack", "est", "all", "ant"]
var patterns_hard = ["tion", "able", "less", "wise", "ment", "hood", "ough"]

var rocket_list = []
