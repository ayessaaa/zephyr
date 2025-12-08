extends CharacterBody2D

@export var gravity = 1000

@onready var animation_player: AnimationPlayer = $CatAnimation/AnimationPlayer
@onready var sprite_2d: AnimatedSprite2D = $CatAnimation/Sprite2D
@onready var text_input: Node2D = $TextInput
@onready var bg_music: AudioStreamPlayer2D = $BgMusic
@onready var hide_animation: AnimationPlayer = $Camera2D/Menu/HideAnimation

const SPEED = 20.0
const JUMP_VELOCITY = -400.0

var last_y = 0


func _physics_process(delta: float) -> void:
	if Global.menu_hide:
		hide_animation.play("hide")
		Global.menu_hide = false
		
	text_input.visible = !(Global.menu or Global.tutorial)
		
	if Global.floating:
		position.y -= 30 * delta
		last_y = position.y
	#if Global.floating:
		#await get_tree().create_timer(1.0).timeout
	else:
		#print(position.y, last_y)
		#if position.y > last_y+500:
			#velocity.y += gravity * delta
			#sprite_2d.play("scared")
		#else:
			#velocity.y = 0
		sprite_2d.play("scared")


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var mouse_position = get_viewport().get_mouse_position()
		
	if Global.menu or Global.tutorial:
		var direction = 0
		if mouse_position.x > 635:
			sprite_2d.play("default")
			direction = 1 
			if animation_player.current_animation != "cursor_to_right":
				animation_player.stop()
				animation_player.queue("cursor_to_right")
				
		elif mouse_position.x < 490:
			direction = -1 
			sprite_2d.play("default")
			if animation_player.current_animation != "cursor_to_left":
				animation_player.stop()
				animation_player.queue("cursor_to_left")
					
		else:
			if mouse_position.y > 25 and mouse_position.y < 200:
				sprite_2d.play("scared")
			else:
				sprite_2d.play("default")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if Input.is_action_just_pressed("ui_left"):
			animation_player.stop()
			animation_player.queue("to_left")
		elif Input.is_action_just_pressed("ui_right"):
			animation_player.stop()
			animation_player.queue("to_right")
			
		elif Input.is_action_just_released("ui_left"):
			animation_player.queue("left_back")
		elif Input.is_action_just_released("ui_right"):
			animation_player.queue("right_back")
			
		elif !Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_right"):
			animation_player.queue("swing")
		#elif !Input.is_action_pressed("ui_left"):
			#if !rotation > -.30:
				#animation_player.play("left_back")

	move_and_slide()


#func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#if anim_name == "to_left" and !Input.is_action_pressed("ui_left"):
		#animation_player.play("left_back")


func _on_bg_music_finished() -> void:
	print("ended")
	bg_music.play()
