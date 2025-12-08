extends Node2D
@onready var bg_animation: AnimationPlayer = get_parent().get_node("Menu/MenuBg/AnimationPlayer")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.gameover_animation:
		await get_tree().create_timer(1.0).timeout
		print("dead")
		bg_animation.play("transition")
		Global.gameover_animation = false
