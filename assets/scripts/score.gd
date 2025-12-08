extends Area2D
@onready var score_animation: AnimationPlayer = $ScoreAnimation


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Global.score_fadeout:
		#score_animation.play("fade_out")
		#Global.score_fadeout = false
	pass
