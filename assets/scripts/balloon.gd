extends RigidBody2D

@onready var player_animation: AnimatedSprite2D = $"../Player/CatAnimation/Sprite2D"
@onready var rope_2: RigidBody2D = $"../Rope2"
@onready var rope_3: RigidBody2D = $"../Rope3"
@onready var rope_4: RigidBody2D = $"../Rope4"
@onready var rope_5: RigidBody2D = $"../Rope5"
@onready var player: CharacterBody2D = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_balloon_area_area_entered(area: Area2D) -> void:
	if area.type == "rocket":
		Global.rocket_list.erase(area)
		area.get_node("Sprite2D").play("explode")
		
		rope_2.queue_free()
		rope_3.queue_free()
		rope_4.queue_free()
		rope_5.queue_free()
		
		Global.floating = false


func _on_balloon_external_area_area_entered(area: Area2D) -> void:
	player_animation.play("scared")


func _on_balloon_external_area_area_exited(area: Area2D) -> void:
	player_animation.play("default")
