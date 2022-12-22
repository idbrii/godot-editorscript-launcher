tool
extends Launchable

const ui = preload("res://addons/editor-script-bar/ui.gd")


static func create_ui(run_btn: Button) -> Control:
    printt("create_ui from")
    var root := VBoxContainer.new()

    root.add_child(ui.vec3("Offset"))
    root.add_child(ui.float("Max Width"))
    root.add_child(run_btn)
    return root


static func run_script(ed: EditorInterface, ui_root: Control):
    # TODO: How do I get the data out of ui?
    var max_width := 100
    var offset := Vector3(1.0, 0, 1.0)

    var selection := ed.get_selection().get_selected_nodes()
    if selection.size() == 1:
        selection = selection[0].get_children()
    var start = selection[0].global_translation
    var pos := Vector3.ZERO
    for item in selection:
        item.global_translation = pos + start
        pos.x += offset.x
        if pos.x > max_width:
            pos += offset
            pos.x = 0

