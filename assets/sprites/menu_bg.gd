extends Node2D
@onready var hide_animation: AnimationPlayer = $"../HideAnimation"


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
