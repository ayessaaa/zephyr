extends Node

var english_words := {}
var beam = preload("uid://cj2fdlneamenu")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _ready():
	load_word_list()

func load_word_list():
	var path := "res://assets/words.txt"
	var file := FileAccess.open(path, FileAccess.READ)

	if file == null:
		push_error("FAILED TO LOAD WORD LIST: " + path)
		return

	while not file.eof_reached():
		var line := file.get_line().strip_edges()
		if line != "":
			english_words[line.to_lower()] = true

	file.close()
	print("Loaded ", english_words.size(), " words.")
		


var patterns_easy = ["an", "in", "on", "at", "it", "en", "er", "ar", "or", "us", "um", "is",
					"th", "sh", "ch", "ph", "st", "tr", "br", "cl", "pr", "dr", "gr", "bl",
					"ed", "es", "ly", "er", "al", "le", "nt", "nd", "ck", "ng",
					"gh", "pt", "wr", "kn", "qu"]
var patterns_medium = [ "str", "ing", "ack", "est", "art", "and", "ant", "ell", "ill", "all",
					"pre", "dis", "con", "sub", "non", "tri", "pro",
					"ing", "ous", "ful", "est", "ity", "ive", "ent",
					"tch", "dge", "ght", "que", "sci", "phr", "chr"]
var patterns_hard = [ "tion", "sion", "ment", "able", "less", "ness", "ward", "wise", "ship", "hood",
					"chro", "phor", "ther", "tion", "ough", "ight",
					"quar", "whic", "phon", "ment", "ture", "ghte", "ough"]

var menu = true
var tutorial = false
var rocket_list = []
var score = 0
var rocket_speed = 50.0
var floating = true

var tutorial_number = 1

var menu_hide = false

var tutorial_done = false
var camera_pos = false

var score_fadeout = false
var score_fadein = false
var will_show_tutorial = true

var gameover = false
var gameover_animation = false

var line_edit_visible = false
var best_score = 99999
