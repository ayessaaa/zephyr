extends Node2D

@onready var label: Label = $Label
@onready var line_edit: LineEdit = $LineEdit
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var camera = get_parent().get_node("Camera2D")
@onready var rocket = get_parent().get_parent().get_node("Rockets/RocketRed/Sprite2D")
@onready var typing_sound: AudioStreamPlayer2D = $TypingSound
@onready var correct_sound: AudioStreamPlayer2D = $CorrectSound
@onready var incorrect_sound: AudioStreamPlayer2D = $IncorrectSound

#func _ready() -> void:
	#line_edit.text_submitted.connect(_on_LineEdit_text_entered)
	#
#func _on_LineEdit_text_entered(new_text: String)-> void:
	#label.text = new_text

func _on_line_edit_text_submitted(new_text: String) -> void:
	#label.text = new_text
	for rocket in Global.rocket_list:
		
		if not new_text.to_lower().find(rocket.pattern.to_lower()) != -1:
			continue
		elif is_real_word(new_text, rocket.pattern):
			animation_player.play("correct")
			camera.trigger_shake("green_bg")
			line_edit.text = ""
			rocket.get_node("Sprite2D").play("explode")
			rocket.get_node("ExplosionSound").play()
			correct_sound.play()
			Global.rocket_list.erase(rocket)
			return
			
	animation_player.play("incorrect")
	camera.trigger_shake("red_bg")
	line_edit.text = ""
	incorrect_sound.play()


func _on_line_edit_text_changed(new_text: String) -> void:
	var caret_column  = line_edit.caret_column 
	line_edit.text = new_text.to_upper()
	line_edit.caret_column  = caret_column 
	typing_sound.play()
	
func is_real_word(word: String, pattern: String) -> bool:
	return Global.english_words.has(word.to_lower())
	
