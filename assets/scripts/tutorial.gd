extends Node2D
@onready var text_animation: AnimationPlayer = $TextAnimation

var tutorial_number = 1
var tutorial_done = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if tutorial_done:
		if Input.is_action_just_pressed("mouse_click"):
			print("click")
			tutorial_number += 1
			text_animation.play(str(tutorial_number))


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	text_animation.play(str(tutorial_number))


func _on_text_animation_animation_finished(anim_name: StringName) -> void:
	print("done")
	tutorial_done = true
