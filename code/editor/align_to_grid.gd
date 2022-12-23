tool
extends LaunchableScript

const ui = preload("res://addons/editorscript-launcher/ui.gd")


class Data extends VBoxContainer:
    var offset #: ui.Vec3
    var max_width #: ui.Float
    var start_at_first #: ui.Boolean

    func _ready():
        start_at_first = ui.Boolean.create("Start At First", self)
        offset = ui.Vec3.create("Offset", self)
        offset.set_value(Vector3(1, 0, 1))
        max_width = ui.Float.create("Max Width", self)
        max_width.val.value = 50


static func create_ui(run_btn: Button) -> Control:
    var root := Data.new()
    root.name = "align_to_grid data"
    root.add_child(run_btn)
    return root


static func run_script(ed: EditorInterface, ui_root: Control):
    var start_at_first = ui_root.start_at_first.val.toggle_mode
    var max_width = ui_root.max_width.val.value
    var offset := ui_root.offset.get_value() as Vector3

    var selection := LaunchableScript.get_selection_or_children(ed)
    if selection.empty():
        push_error("No items selected.")
        return

    var start = Vector3.ZERO
    if start_at_first:
        start = selection[0].global_translation
    var pos := Vector3.ZERO
    for item in selection:
        item.global_translation = pos + start
        pos.x += offset.x
        if pos.x > max_width:
            pos += offset
            pos.x = 0

