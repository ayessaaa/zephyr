extends Node2D
@onready var balloon_animation_player: AnimationPlayer = $Balloon/BalloonAnimationPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var balloon_sprite: AnimatedSprite2D = $Balloon/BalloonSprite
@onready var subtitle: Label = $Subtitle
@onready var cat_animation_player: AnimationPlayer = $Cat/CatAnimationPlayer

var customizing = ""
var fade_in = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.style and !fade_in:
		await get_tree().create_timer(1.0).timeout 
		animation_player.play("fade_in")
		fade_in = true


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
	if customizing != "balloon":
		customizing = "balloon"
		animation_player.play("balloon_selected")
		balloon_animation_player.play("pressed")
		subtitle.text = "balloon"


func _on_cat_button_mouse_entered() -> void:
	cat_animation_player.play("hover")


func _on_cat_button_mouse_exited() -> void:
	cat_animation_player.play("unhover")


func _on_cat_button_pressed() -> void:
	if customizing != "cat":
		customizing = "cat"
		animation_player.play("cat_selected")
		cat_animation_player.play("pressed")
		subtitle.text = "cat"
