extends VBoxContainer


var recolor: Signal


func _ready() -> void:
	var r = randf()
	var g = randf()
	var b = randf()
	$ColorPickerButton.color = Color(r, g, b)


func _on_minus_button_pressed() -> void:
	self.recolor.emit(-1)
	self.queue_free()


func params(recolor: Signal) -> void:
	self.recolor = recolor


func get_color():
	return $ColorPickerButton.color


func _on_color_picker_button_color_changed(color: Color) -> void:
	self.recolor.emit(0)
