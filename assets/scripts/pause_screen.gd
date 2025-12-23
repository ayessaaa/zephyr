extends Node2D
@onready var score: Label = $TextureRect/Score
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score.text = str(Global.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_resume_button_pressed() -> void:
	#Global.pause = false
	animation_player.play("out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "out":
		Global.pause = false
