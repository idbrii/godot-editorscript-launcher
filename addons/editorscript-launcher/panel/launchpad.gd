@tool
extends Control

const FuncButton = preload("res://addons/editorscript-launcher/panel/funcbutton.gd")

var plugin #: EditorPlugin


func get_files_in_dir(path: String) -> Array:
	var files := []
	var dir = DirAccess.open(path)
	var err = DirAccess.get_open_error()
	if err == OK:
		dir.list_dir_begin()
		var file_name := dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				files.append(file_name)
			file_name = dir.get_next()
	elif err == ERR_INVALID_PARAMETER:
		print("Error. Path doesn't exist: ", path)
	else:
		print("Error ", err, " occurred when trying to access the path: ", path)

	return files


func load_from_path(path: String, ed: EditorInterface):
	var basic := $"%BasicButtons"
	var complex := $"%ComplexButtons"
	for item in basic.get_children():
		item.queue_free()
	for item in complex.get_children():
		item.queue_free()

	var files := get_files_in_dir(path)
	for f in files:
		if not f.ends_with(".gd"):
			continue

		var fullpath = path.path_join(f)

		var target = load(fullpath)
		var btn := FuncButton.new()
		btn.target = target
		assert(btn.target, "Failed to load script %s" % fullpath)
		btn.ed = ed
		#~ assert(btn.target.has_method("run_script"), "Scripts must have a run_script: %s" % fullpath)
		btn.text = f.get_basename().capitalize()
		btn.set_size(Vector2(80,20))
		btn.show()

		var widget = target.create_ui(btn)
		btn.ui_root = widget

		if widget == btn:
			basic.add_child(widget)
		else:
			complex.add_child(widget)
			var spacer := Label.new()
			spacer.custom_minimum_size.x = 10
			complex.add_child(spacer)

		if btn.get_parent() == null:
			widget.add_child(btn)

const SCRIPT_PATH := "res://code/editor/"
func _ready():
	load_from_path(SCRIPT_PATH, null)


func _on_reload_pressed():
	load_from_path(SCRIPT_PATH, plugin.get_editor_interface())

