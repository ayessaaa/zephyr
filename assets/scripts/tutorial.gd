extends Node2D
@onready var text_animation: AnimationPlayer = $TextAnimation
@onready var rocket_red: AnimatedSprite2D = $RocketRed
@onready var label: Label = $RocketRed/Label
@onready var menu_transition_animation: AnimationPlayer = get_parent().get_node("MenuBg/AnimationPlayer")
@onready var score_animation: AnimationPlayer = get_parent().get_parent().get_node("Score/ScoreAnimation")
@onready var text_input_animation: AnimationPlayer = $TextInput/AnimationPlayer
@onready var exit_button: TextureButton = $ExitButton
@onready var exit_animation_player: AnimationPlayer = $ExitButton/AnimationPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer


const light_blue_pressed = preload("uid://cktqipxapbjgj")
const light_blue_hover = preload("uid://ceb8184idqbpc")
const dark_blue_pressed = preload("uid://gsil1sdlan1f")
const dark_blue_hover = preload("uid://bhd8nnybd4jyl")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	exit_button.visible = Global.tutorial
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
			
		if Global.tutorial_number >= 4 and Global.tutorial_number <= 5:
			exit_button.texture_pressed = dark_blue_pressed
			exit_button.texture_hover = dark_blue_hover
		else:
			exit_button.texture_pressed = light_blue_pressed
			exit_button.texture_hover = light_blue_hover


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
	if Global.tutorial_number == 4:
		text_input_animation.play("fade_in")
	


func _on_rocket_red_animation_finished() -> void:
	Global.tutorial_done = true
	rocket_red.queue_free()


func _on_exit_button_pressed() -> void:
	text_animation.stop()
	if Global.tutorial_number == 4 or Global.tutorial_number == 5:
		animation_player.play("fade_out_2")
	else:
		animation_player.play("fade_out")
	Global.score_fadein = true
	exit_animation_player.play("fade_out")
	Global.tutorial_number = 10
	
	await get_tree().create_timer(.5).timeout 
	Global.camera_pos = true
	menu_transition_animation.play("transition_out")
	
