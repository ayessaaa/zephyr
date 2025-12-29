extends Node2D
@onready var balloon_animation_player: AnimationPlayer = $Balloon/BalloonAnimationPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var balloon_sprite: AnimatedSprite2D = $Balloon/BalloonSprite
@onready var subtitle: Label = $Subtitle

var customizing = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#func _on_balloon_area_mouse_entered() -> void:
	#print("hover")
	#balloon_animation_player.play("hover")


func _on_balloon_button_mouse_entered() -> void:
	if customizing == "":
		balloon_animation_player.play("hover")


func _on_balloon_button_mouse_exited() -> void:
	if customizing == "":
		balloon_animation_player.play("unhover")


func _on_balloon_button_pressed() -> void:
	#balloon_sprite.scale = Vector2(0.96, 0.96)
	customizing = "balloon"
	animation_player.play("balloon_selected")
	balloon_animation_player.play("pressed")
	subtitle.text = "balloon"
