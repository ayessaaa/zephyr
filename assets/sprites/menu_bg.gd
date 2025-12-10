extends Node2D
@onready var hide_animation: AnimationPlayer = $"../HideAnimation"
#@onready var line_edit: LineEdit = get_parent().get_parent().get_parent().get_node("LineEdit")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "transition_out" and Global.tutorial:
		Global.tutorial = false
	if anim_name == "transition":
		Global.menu_hide = true
	if anim_name == "transition_screen" and !Global.will_show_tutorial:
		Global.tutorial = false
	if anim_name == "in" and Global.gameover:
		Global.line_edit_visible = false
	if anim_name == "out":
		Global.gameover = false
		Global.restart = true
		Global.floating = true
		Global.score_fadeout = false
		Global.gameover_animation = false
		Global.line_edit_visible = true
		Global.rocket_list = []
		Global.score = 0
		Global.rocket_speed = 50.0
		#menu_transition_animation.play("transition_out")
		Global.score_fadein = true
		


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "transition_screen" and !Global.will_show_tutorial:
		await get_tree().create_timer(1.0).timeout
		Global.menu_hide = true
		Global.camera_pos = true
		Global.score_fadein = true
	
