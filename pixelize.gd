extends Control

var settings_button: Button

func _ready():
	settings_button = $CanvasLayer/VBoxContainer/SettingsButton
	settings_button.text = "▲"
	if (PassTexture.image_texture != null):
		$TextureRect.texture = PassTexture.image_texture

	
func _on_settings_button_pressed() -> void:
	settings_button.text = "▲" if settings_button.text == "▼" else "▼"
	$CanvasLayer/VBoxContainer/ControlsContainer.visible = not $CanvasLayer/VBoxContainer/ControlsContainer.visible 


func _on_save_button_pressed() -> void:
	var subviewport = SubViewport.new()
	var texturerect = $TextureRect.duplicate()
	subviewport.add_child(texturerect)
	subviewport.size = texturerect.texture.get_size()
	subviewport.set_update_mode(subviewport.UPDATE_ONCE)
	$CanvasLayer.add_child(subviewport)
	texturerect.position = Vector2.ZERO
	var texture = subviewport.get_texture()
	await RenderingServer.frame_post_draw
	var image = texture.get_image()
	var image_texture = ImageTexture.create_from_image(image)
	ResourceSaver.save(image_texture, "res://test.tres")
	subviewport.queue_free()


func _on_zoom_slider_value_changed(value: float) -> void:
	$Camera2D.zoom = Vector2.ONE * value 


func _on_kernel_slider_value_changed(value: float) -> void:
	var mat = $TextureRect.get_material()
	mat.set("shader_parameter/pkernel_size", int(value))
	mat.set("shader_parameter/image", $TextureRect.texture)
