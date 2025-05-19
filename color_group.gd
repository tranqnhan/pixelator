extends VBoxContainer


func _ready() -> void:
	var r = randf()
	var g = randf()
	var b = randf()
	$ColorPickerButton.color = Color(r, g, b)


func _on_minus_button_pressed() -> void:
	self.queue_free()


func get_color():
	return $ColorPickerButton.color
