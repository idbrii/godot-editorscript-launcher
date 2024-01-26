@tool
extends LaunchableScript

const ui = preload("res://addons/editorscript-launcher/ui.gd")


class Data extends VBoxContainer:
	var radius #: ui.Float

	func _ready():
		var label := Label.new()
		label.text = "Lays out children of selected node in a circle."
		add_child(label)
		radius = ui.Float.create("Radius", self)
		radius.val.value = 10
		custom_minimum_size.x = 200


static func create_ui(run_btn: Button) -> Control:
	var root := Data.new()
	root.name = "layout_circle data"
	root.add_child(run_btn)
	return root


static func run_script(ed: EditorInterface, ui_root: Control):
	var radius = ui_root.radius.val.value

	var top := LaunchableScript.get_first_selection(ed)
	var selection := LaunchableScript.sort_by_child_index(top.get_children())
	if selection.size() < 2:
		push_error("%s doesn't have enough children to layout in circle." % top)
		return

	var angle := 0.0
	var delta := TAU / (selection.size())
	for item in selection:
		item.translation = Vector3.RIGHT.rotated(Vector3.UP, angle) * radius
		angle += delta
		#~ printt(item, angle)

