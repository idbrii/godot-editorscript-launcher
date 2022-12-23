tool
extends Launchable

const ui = preload("res://addons/editor-script-bar/ui.gd")


class Data extends VBoxContainer:
    var offset #: ui.Vec3
    var max_width #: ui.Float

    func _ready():
        offset = ui.Vec3.create("Offset", self)
        max_width = ui.Float.create("Max Width", self)
        rect_min_size.x = 200


static func create_ui(run_btn: Button) -> Control:
    printt("create_ui from align_to_grid.gd")

    var root := Data.new()
    root.add_child(run_btn)
    return root


static func run_script(ed: EditorInterface, ui_root: Control):
    # TODO: How do I get the data out of ui?
    var max_width = ui_root.max_width.get_value()
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

