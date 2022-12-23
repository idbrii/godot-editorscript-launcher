tool
extends LaunchableScript

const ui = preload("res://addons/editor-script-bar/ui.gd")


class Data extends VBoxContainer:
    var offset #: ui.Vec3
    var max_width #: ui.Float

    func _ready():
        offset = ui.Vec3.create("Offset", self)
        offset.set_value(Vector3(1, 0, 1))
        max_width = ui.Float.create("Max Width", self)
        max_width.val.value = 50
        rect_min_size.x = 200


static func create_ui(run_btn: Button) -> Control:
    printt("create_ui from align_to_grid.gd")

    var root := Data.new()
    root.name = "align_to_grid data"
    root.add_child(run_btn)
    return root


static func run_script(ed: EditorInterface, ui_root: Control):
    var max_width = ui_root.max_width.val.value
    var offset := ui_root.offset.get_value() as Vector3

    var selection := LaunchableScript.get_selection_or_children(ed)
    var start = selection[0].global_translation
    var pos := Vector3.ZERO
    for item in selection:
        item.global_translation = pos + start
        pos.x += offset.x
        if pos.x > max_width:
            pos += offset
            pos.x = 0

