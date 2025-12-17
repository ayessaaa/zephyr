extends Node2D

@onready var label: Label = $Label
@onready var line_edit: LineEdit = $LineEdit
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var camera = get_parent().get_node("Camera2D")
@onready var rocket = get_parent().get_parent().get_node("Rockets/RocketRed/Sprite2D")
@onready var typing_sound: AudioStreamPlayer2D = $TypingSound
@onready var correct_sound: AudioStreamPlayer2D = $CorrectSound
@onready var incorrect_sound: AudioStreamPlayer2D = $IncorrectSound
@onready var score_animation: AnimationPlayer = get_parent().get_node("Camera2D/Score/ScoreAnimation")
@onready var bg_music: AudioStreamPlayer2D = $"../../BgMusic"
@onready var explosion_sound: AudioStreamPlayer2D = $ExplosionSound
@onready var airplanes_node = get_parent().get_node("Camera2D/Airplanes")

var score = 0

#func _ready() -> void:
	#line_edit.text_submitted.connect(_on_LineEdit_text_entered)
	#
#func _on_LineEdit_text_entered(new_text: String)-> void:
	#label.text = new_text

func _on_line_edit_text_submitted(new_text: String) -> void:
	if Global.gameover:
		return
	#label.text = new_text
	for rocket in Global.rocket_list:
		#if rocket.is_free():
			#
		if not new_text.to_lower().find(rocket.pattern.to_lower()) != -1:
			print("no sequence")
			continue
		if is_real_word(new_text, rocket.pattern):
			print("correct")
			
			animation_player.play("correct")
			camera.trigger_shake("green_bg")
			line_edit.text = ""
			rocket.get_node("Sprite2D").play("explode")
			rocket.show_score = true
			correct_sound.play()
			
			if rocket.color == "red":
				score = len(new_text)*27
			elif rocket.color == "green":
				score = len(new_text)*48
			else:
				score = len(new_text)*69
				
			rocket.score = score
			Global.score += score
			Global.rocket_speed += score*0.01
			score_animation.play("scored")
			
			Global.rocket_list.erase(rocket)
			
			explosion_sound.play()
			rocket.get_node("CollisionPolygon2D").disabled = true
			
			return
			
		
		else:
			print("not found")
			
	if new_text.to_lower().find(Global.powerup_letters.to_lower()) and is_real_word(new_text, Global.powerup_letters):
		
		camera.trigger_shake("yellow_bg")
		line_edit.text = ""
		#airplane_sprite.play("disappear")
		airplanes_node.get_child(0).get_node("Path2D/PathFollow2D/AnimatedSprite2D").play("disappear")
		airplanes_node.get_child(0).get_node("Path2D/PathFollow2D/AnimatedSprite2D/Letters").visible = false
		Global.powerup = true
		
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
	
