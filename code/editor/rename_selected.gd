@tool
extends LaunchableScript


# Mostly an example of a script without any UI.
static func run_script(ed: EditorInterface, ui_root: Control):
	var selection := LaunchableScript.get_selection_or_children(ed)
	if selection.is_empty():
		push_error("No items selected.")
		return

	var i := 0
	var prefix = selection[0].name.rstrip(" 0123456789")
	for item in selection:
		var name := "%s %d" % [prefix, i]
		printt(item.name, "->", name)
		item.name = name
		i += 1
