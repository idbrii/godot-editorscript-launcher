@tool
extends EditorPlugin

const bar_scene = preload("res://addons/editorscript-launcher/panel/launchpad.tscn")
const EDITOR_SETTINGS_PROPERTY_INFO_NAME := "script_launcher/general/custom_editor_script_dir"

var script_path := "res://code/editor/"

var bar
var bar_btn: Button


func _enter_tree():
	# Custom config in Editor Setting
	var settings = EditorInterface.get_editor_settings()
	settings.add_property_info({
		"name": EDITOR_SETTINGS_PROPERTY_INFO_NAME,
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_DIR,
		"hint_string": "custom editor script dir source",
	})
	# Trigger reload when setting changed
	settings.settings_changed.connect(_on_settings_changed)
	# Try get custom setting of script source dir
	var settings_script_path = _get_script_path_from_setting()
	if settings_script_path.is_empty():
		settings.set_setting(EDITOR_SETTINGS_PROPERTY_INFO_NAME, script_path)
	else:
		script_path = settings_script_path
	
	bar = bar_scene.instantiate()
	bar.plugin = self
	
	bar_btn = add_control_to_bottom_panel(bar, "Script Launcher")
	bar_btn.flat = true
	# Need extra space to push above toolbar buttons. Bottom margin didn't work.
	bar.custom_minimum_size.y = bar.size.y + 50


func _exit_tree():
	if bar:
		remove_control_from_bottom_panel(bar)
		bar.queue_free()
		

func _on_settings_changed():
	var setting_script_path = _get_script_path_from_setting()
	if setting_script_path == script_path:
		return
		
	script_path = setting_script_path
	if bar != null:
		bar.load_from_path(script_path, get_editor_interface())
		print("script launcher reload scripts")
	

func _get_script_path_from_setting():
	var settings = EditorInterface.get_editor_settings()
	if settings.has_setting(EDITOR_SETTINGS_PROPERTY_INFO_NAME):
		return settings.get_setting(EDITOR_SETTINGS_PROPERTY_INFO_NAME)
	else:
		""
