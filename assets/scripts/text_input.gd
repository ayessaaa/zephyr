extends Node2D

@onready var label: Label = $Label
@onready var line_edit: LineEdit = $LineEdit
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var camera = get_parent().get_node("Camera2D")

#func _ready() -> void:
	#line_edit.text_submitted.connect(_on_LineEdit_text_entered)
	#
#func _on_LineEdit_text_entered(new_text: String)-> void:
	#label.text = new_text

var patterns = ["AD", "PS"]

func _on_line_edit_text_submitted(new_text: String) -> void:
	#label.text = new_text
	for pattern in patterns:
		
		if not new_text.to_lower().find(pattern.to_lower()) != -1:
			continue
		elif is_real_word(new_text, pattern):
			animation_player.play("correct")
			camera.trigger_shake("green_bg")
			line_edit.text = ""
			return
			
	animation_player.play("incorrect")
	camera.trigger_shake("red_bg")
	line_edit.text = ""


func _on_line_edit_text_changed(new_text: String) -> void:
	var caret_column  = line_edit.caret_column 
	line_edit.text = new_text.to_upper()
	line_edit.caret_column  = caret_column 
	
func is_real_word(word: String, pattern: String) -> bool:
	return Global.english_words.has(word.to_lower())
	
