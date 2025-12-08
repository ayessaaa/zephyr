extends Node2D
@onready var text_animation: AnimationPlayer = $TextAnimation
@onready var rocket_red: AnimatedSprite2D = $RocketRed
@onready var label: Label = $RocketRed/Label
@onready var menu_transition_animation: AnimationPlayer = get_parent().get_node("MenuBg/AnimationPlayer")
@onready var score_animation: AnimationPlayer = get_parent().get_parent().get_node("Score/ScoreAnimation")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !Global.will_show_tutorial:
		return
	if Global.tutorial_done:
		if Input.is_action_just_pressed("mouse_click") and Global.tutorial_number != 4:
			if Global.tutorial_number == 8:
				text_animation.play(str(Global.tutorial_number))
				Global.tutorial_number += 1
			else:
				print("click")
				Global.tutorial_number += 1
				text_animation.play(str(Global.tutorial_number))
				#if Global.tutorial_number == 5 or Global.tutorial_number == 4:
					#Global.tutorial_done = false
				
		if Global.tutorial_number == 6:
			rocket_red.play("explode")
			label.visible = false
			Global.tutorial_number = 7
			Global.tutorial_done = false
		if Global.tutorial_number == 7:
			text_animation.play("7")
			Global.tutorial_number = 8
			Global.tutorial_done = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	text_animation.play(str(Global.tutorial_number))


func _on_text_animation_animation_finished(anim_name: StringName) -> void:
	print("done")
	Global.tutorial_done = true
	if Global.tutorial_number == 5:
		Global.tutorial_number = 6
		#tutorial_done = false
	if Global.tutorial_number == 9:
		menu_transition_animation.play("transition_out")
		Global.score_fadein = true
		Global.camera_pos = true
	


func _on_rocket_red_animation_finished() -> void:
	Global.tutorial_done = true
	rocket_red.queue_free()
