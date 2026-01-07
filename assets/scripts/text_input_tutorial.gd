extends Node2D

@onready var label: Label = $Label
@onready var line_edit: LineEdit = $LineEdit
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var camera = get_parent().get_parent().get_parent()
@onready var rocket = get_parent().get_parent().get_node("Rockets/RocketRed/Sprite2D")
@onready var typing_sound: AudioStreamPlayer2D = $TypingSound
@onready var correct_sound: AudioStreamPlayer2D = $CorrectSound
@onready var incorrect_sound: AudioStreamPlayer2D = $IncorrectSound
@onready var score_animation: AnimationPlayer = get_parent().get_parent().get_node("Score/ScoreAnimation")
@onready var bg_music: AudioStreamPlayer2D = $"../../BgMusic"
@onready var rocket_red: AnimatedSprite2D = $"../RocketRed"
@onready var text_animation: AnimationPlayer = $"../TextAnimation"

var score = 0

#func _ready() -> void:
	#line_edit.text_submitted.connect(_on_LineEdit_text_entered)
	#
#func _on_LineEdit_text_entered(new_text: String)-> void:
	#label.text = new_text

func _on_line_edit_text_submitted(new_text: String) -> void:
	#label.text = new_text
	if new_text.to_lower() == "so":
		animation_player.play("incorrect")
		camera.trigger_shake("red_bg")
		line_edit.text = ""
		incorrect_sound.play()
		return
	elif not new_text.to_lower().find("so") != -1:
		animation_player.play("incorrect")
		camera.trigger_shake("red_bg")
		line_edit.text = ""
		incorrect_sound.play()
		return
	elif is_real_word(new_text, "so"):
		animation_player.play("correct")
		camera.trigger_shake("green_bg")
		line_edit.text = ""
		#rocket_red.play("explode")
		#rocket.get_node("Sprite2D").play("explode")
		text_animation.play("5")
		correct_sound.play()
		Global.tutorial_number = 5
		Global.tutorial_done = false
		return
				
		#Global.score += score
		#Global.rocket_speed += score*0.01
		#score_animation.play("scored")
			#
		#Global.rocket_list.erase(rocket)
			
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
	
