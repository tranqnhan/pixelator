extends Control

@export var color_group : PackedScene

var MAX_COLORS = 256
var colors_container
var settings_button 
var textures

func _ready():
	colors_container = $VBoxContainer/VBoxContainer/HboxContainer/HBoxContainer/ScrollContainer/ColorsContainer
	textures = $TextureRect
	settings_button = $VBoxContainer/SettingsButton
	settings_button.text = "▲"
	print(len(colors_container.get_children()))


func load_image(path: String):
	if path.begins_with('res'):
		return load(path)
	else:
		var file = FileAccess.open(path, FileAccess.READ)
		if FileAccess.get_open_error() != OK:
			print(str("Could not load image at: ",path))
			return
		var image = Image.load_from_file(path)
		#var buffer = file.get_buffer(file.get_length())
		#var image = Image.new()
		#var error = image.load_from_buffer(buffer)
		#if error != OK:
		#	print(str("Could not load image at: ",path," with error: ",error))
		#	return
		var texture = ImageTexture.create_from_image(image)
		return texture


func _on_import_picture_button_pressed() -> void:
	$FileDialog.visible = true


func _on_file_dialog_file_selected(path: String) -> void:
	textures.texture = load_image(path)


func _on_apply_colors_button_pressed() -> void:
	var colors = []
	var guard = 0
	for i in colors_container.get_children():
		colors.append(i.get_color())
		if (guard >= MAX_COLORS):
			break
		else:
			guard += 1
	
	var num_colors = guard
	var material : Material = textures.get_material()
	material.set("shader_parameter/colors", colors)
	material.set("shader_parameter/num_colors", num_colors)
	# SHADER


func _on_add_button_pressed() -> void:
	if (len(colors_container.get_children()) < MAX_COLORS):
		var color = color_group.instantiate()
		colors_container.add_child(color)


func _on_settings_button_pressed() -> void:
	settings_button.text = "▲" if settings_button.text == "▼" else "▼"
	$VBoxContainer/VBoxContainer.visible = not $VBoxContainer/VBoxContainer.visible 
