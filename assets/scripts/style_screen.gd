extends Node2D
@onready var balloon_animation_player: AnimationPlayer = $Balloon/BalloonAnimationPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var balloon_sprite: AnimatedSprite2D = $Balloon/BalloonSprite
@onready var balloon_white: AnimatedSprite2D = $Balloon/BalloonSprite/BalloonWhite
@onready var subtitle: Label = $Subtitle
@onready var cat_animation_player: AnimationPlayer = $Cat/CatAnimationPlayer
@onready var hover_music: AudioStreamPlayer2D = $HoverMusic
@onready var select_music: AudioStreamPlayer2D = $SelectMusic
@onready var menu_transition_animation: AnimationPlayer = get_parent().get_node("Menu/MenuBg/AnimationPlayer")
@onready var exit_sound: AudioStreamPlayer2D = $ExitSound

#var balloon_colors = ["red", "yellow", "green", "lilac", "purple"]
var balloon_color = "yellow"
var balloon_shapes = ["default", "star", "sparkle", "moon", "mickey", "heart"]
var balloon_index = 0

var customizing = ""
var fade_in = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


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
	if customizing != "balloon":
		balloon_animation_player.play("hover")
		hover_music.play()


func _on_balloon_button_mouse_exited() -> void:
	if customizing != "balloon":
		balloon_animation_player.play("unhover")


func _on_balloon_button_pressed() -> void:
	if customizing != "balloon":
		if customizing == "cat":
			animation_player.play("balloon_selected_2")
			balloon_animation_player.play("pressed")
		else:
			animation_player.play("balloon_selected")
			balloon_animation_player.play("pressed")
		customizing = "balloon"
		subtitle.text = "balloon"
		select_music.play()


func _on_cat_button_mouse_entered() -> void:
	if customizing != "cat":
		cat_animation_player.play("hover")
		hover_music.play()


func _on_cat_button_mouse_exited() -> void:
	if customizing != "cat":
		cat_animation_player.play("unhover")


func _on_cat_button_pressed() -> void:
	if customizing != "cat":
		if customizing == "balloon":
			animation_player.play("cat_selected_2")
			cat_animation_player.play("pressed")
		else:
			animation_player.play("cat_selected")
			cat_animation_player.play("pressed")
		customizing = "cat"
		subtitle.text = "cat"
		select_music.play()
		


func _on_right_button_pressed() -> void:
	if customizing == "balloon":
		if balloon_index == len(balloon_shapes)-1:
			balloon_index = 0
		else:
			balloon_index += 1
		balloon_sprite.play(balloon_shapes[balloon_index]+"_"+balloon_color)
		balloon_white.play(balloon_shapes[balloon_index])
		select_music.play()
		balloon_animation_player.play("switch")


func _on_left_button_pressed() -> void:
	if customizing == "balloon":
		if balloon_index == 0:
			balloon_index = len(balloon_shapes)-1
		else:
			balloon_index -= 1
		balloon_sprite.play(balloon_shapes[balloon_index]+"_"+balloon_color)
		balloon_white.play(balloon_shapes[balloon_index])
		select_music.play()
		balloon_animation_player.play("switch")


func _on_red_button_mouse_entered() -> void:
	hover_music.play()


func _on_yellow_button_mouse_entered() -> void:
	hover_music.play()


func _on_green_button_mouse_entered() -> void:
	hover_music.play()


func _on_lilac_button_mouse_entered() -> void:
	hover_music.play()


func _on_purple_button_mouse_entered() -> void:
	hover_music.play()


func _on_left_button_mouse_entered() -> void:
	hover_music.play()


func _on_right_button_mouse_entered() -> void:
	hover_music.play()


func _on_exit_button_pressed() -> void:
	animation_player.play("fade_out")
	exit_sound.play()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out" and Global.style:
		Global.menu = true
		Global.style = false
		Global.settings = false
		Global.hide_buttons = false
		fade_in = false
		menu_transition_animation.play("transition_out")
		menu_transition_animation.queue("inside_screen")


func _on_red_button_pressed() -> void:
	balloon_color = "red"
	balloon_sprite.play(balloon_shapes[balloon_index]+"_"+balloon_color)
	select_music.play()
	balloon_animation_player.play("switch")


func _on_yellow_button_pressed() -> void:
	balloon_color = "yellow"
	balloon_sprite.play(balloon_shapes[balloon_index]+"_"+balloon_color)
	select_music.play()
	balloon_animation_player.play("switch")


func _on_green_button_pressed() -> void:
	balloon_color = "green"
	balloon_sprite.play(balloon_shapes[balloon_index]+"_"+balloon_color)
	select_music.play()
	balloon_animation_player.play("switch")


func _on_lilac_button_pressed() -> void:
	balloon_color = "lilac"
	balloon_sprite.play(balloon_shapes[balloon_index]+"_"+balloon_color)
	select_music.play()
	balloon_animation_player.play("switch")


func _on_purple_button_pressed() -> void:
	balloon_color = "purple"
	balloon_sprite.play(balloon_shapes[balloon_index]+"_"+balloon_color)
	select_music.play()
	balloon_animation_player.play("switch")
