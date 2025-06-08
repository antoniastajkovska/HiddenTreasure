extends Node3D

@onready var hud = get_node("/root/Main/HUD")


var is_open := false

func _ready():
	pass

func open_chest():
	if !is_open:
		$AnimationPlayer.play("treasure_chest_lidAction")
		$ChestOpenSound.play()
		Global.chest += 1
		hud.get_node("ChestLabel").text = str(Global.chest)
		is_open = true
		


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if Global.collected_all():
				get_tree().change_scene_to_file("res://Scenes/menu_won.tscn")
