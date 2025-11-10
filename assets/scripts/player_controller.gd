extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $CatAnimation/AnimationPlayer

const SPEED = 25.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	#if Global.menu:
		#return
	# Add the gravity.
	#if not is_on_floor():
	position.y -= 30 * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
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
