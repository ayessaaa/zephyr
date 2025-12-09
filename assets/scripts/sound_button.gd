extends TextureButton
const with_normal = preload("uid://b0i7xgxgmocfq")
const with_hover = preload("uid://c63uh0x12r6be")
const with_pressed = preload("uid://ci4k3jqmlp1cx")
const without_normal = preload("uid://bgrvhl1bmbjrh")
const without_hover = preload("uid://d3eh6fkmmp3uc")
const without_pressed = preload("uid://b7dbdklxnvs4r")

var mute = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if mute:
		texture_normal = with_normal
		texture_hover = with_hover
		texture_pressed = with_pressed
		mute = false
	else:
		texture_normal = without_normal
		texture_hover = without_hover
		texture_pressed = without_pressed
		mute = true
