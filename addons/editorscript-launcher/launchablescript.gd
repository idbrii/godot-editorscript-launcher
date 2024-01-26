@tool
extends EditorScript
class_name LaunchableScript


# All of your editor scripts need to extend LaunchableScript and live in
# res://code/editor/
#
# API
# Child classes should override these.

static func create_ui(run_btn: Button) -> Control:
	return run_btn


static func run_script(ed: EditorInterface, ui_root: Control):
	pass


# We override run so you can test from the script editor, but you must handle
# not getting any UI.
func _run():
	run_script(get_editor_interface(), null)


#
# Helper functions
# Useful for implementing scripts.

# Get selected nodes or if only one is selected, get its children.
static func get_selection_or_children(ed: EditorInterface) -> Array:
	var selection := ed.get_selection().get_transformable_selected_nodes()
	if selection.size() == 1 and selection[0].get_child_count() > 1:
		selection = selection[0].get_children()
	# Sort to ensure results match order seen in editor.
	return sort_by_child_index(selection)


# Get selected nodes or if only one is selected, get its children.
static func get_first_selection(ed: EditorInterface) -> Node:
	var selection := ed.get_selection().get_selected_nodes()
	return selection[0]


# Sort the input list of nodes by their child index so they match the order
# seen in editor.
static func sort_by_child_index(items: Array) -> Array:
	items.sort_custom(func(a, b): a.get_index() < b.get_index())
	return items
