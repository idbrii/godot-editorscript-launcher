tool
extends LaunchableScript

const ui = preload("res://addons/editorscript-launcher/ui.gd")


enum StartChoice {
    START_AT_FIRST,
    START_AT_LOCAL_ZERO,
    START_AT_WORLD_ZERO,
}


class Data extends VBoxContainer:
    var offset #: ui.Vec3
    var max_width #: ui.Float
    var start_point #: ui.Boolean

    func _ready():
        start_point = ui.Choice.create("", StartChoice, self)
        offset = ui.Vec3.create("Offset", self)
        offset.set_value(Vector3(1, 0, 1))
        max_width = ui.Float.create("Max Width", self)
        max_width.val.value = 10


static func create_ui(run_btn: Button) -> Control:
    var root := Data.new()
    root.name = "align_to_grid data"
    root.add_child(run_btn)
    return root


static func run_script(ed: EditorInterface, ui_root: Control):
    var start_point = ui_root.start_point.get_selected_value()
    var max_width = ui_root.max_width.val.value
    var offset := ui_root.offset.get_value() as Vector3

    var selection := LaunchableScript.get_selection_or_children(ed)
    if selection.empty():
        push_error("No items selected.")
        return

    var start: Vector3
    match start_point:
        StartChoice.START_AT_LOCAL_ZERO:
            start = selection[0].get_parent().global_translation
        StartChoice.START_AT_FIRST:
            start = selection[0].global_translation
        StartChoice.START_AT_WORLD_ZERO:
            start = Vector3.ZERO

    var pos := Vector3.ZERO
    for item in selection:
        item.global_translation = pos + start
        pos.x += offset.x
        if pos.x > max_width:
            pos += offset
            pos.x = 0

