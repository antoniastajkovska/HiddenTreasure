extends Area3D

const ROT_SPEED = 2
@export var hud : CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(ROT_SPEED))

func _on_body_entered(body: Node3D) -> void:
	Global.coins += 1
	hud.get_node("CoinsLabel").text = str(Global.coins)
	if Global.collected_all():
				get_tree().change_scene_to_file("res://Scenes/menu_won.tscn")
	set_collision_layer_value(3,false)
	set_collision_mask_value(1,false)
	$AnimationPlayer.play("bounce")
	$CoinSound.play()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
