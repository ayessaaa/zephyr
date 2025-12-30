extends Node2D

@onready var BG_MUSIC = AudioServer.get_bus_index("BgMusic")
@onready var SFX = AudioServer.get_bus_index("SFX")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var menu_transition_animation: AnimationPlayer = get_parent().get_node("Menu/MenuBg/AnimationPlayer")
@onready var sfx: HSlider = $SFX
@onready var music: HSlider = $Music
@onready var exit_sound_2: AudioStreamPlayer2D = $ExitSound2
@onready var exit_sound: AudioStreamPlayer2D = $ExitSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioServer.set_bus_volume_db(SFX, Global.sfx_volume)
	AudioServer.set_bus_volume_db(BG_MUSIC, Global.music_volume)
	
	
	sfx.value = Global.sfx_volume
	music.value = Global.music_volume


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX, value)
	if value == -20:
		AudioServer.set_bus_mute(SFX, true)
	else:
		AudioServer.set_bus_mute(SFX, false)
	Global.sfx_volume = value


func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(BG_MUSIC, value)
	if value == -20:
		AudioServer.set_bus_mute(BG_MUSIC, true)
	else:
		AudioServer.set_bus_mute(BG_MUSIC, false)
	Global.music_volume = value
	

func _on_exit_button_pressed() -> void:
	animation_player.play("fade_out")
	exit_sound.play()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out" and Global.settings:
		Global.menu = true
		Global.settings = false
		#exit_sound_2.play()
		menu_transition_animation.play("transition_out")
		menu_transition_animation.queue("inside_screen")
