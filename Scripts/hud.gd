extends CanvasLayer

@export var stopwatch_label : Label

var stopwatch : Stopwatch

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CoinsLabel.text = str(0)
	$ChestLabel.text = str(0)
	$ChestOpenLabel.visible = false
	stopwatch =  get_tree().get_first_node_in_group("stopwatch")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_stopwatch_label()
	
func update_stopwatch_label():
	stopwatch_label.text = stopwatch.time_to_string()
	change_color_of_timer()

func change_color_of_timer():
	if stopwatch.get_time() <= 11:
		stopwatch_label.add_theme_color_override("font_color", Color(1,0,0))
