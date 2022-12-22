tool
extends EditorScript


func _run():
    run_script(get_editor_interface())

static func run_script(ed: EditorInterface):
    var max_width := 100
    var offset := Vector3(1.0, 0, 1.0)

    var sel := ed.get_selection()
    var first := sel.get_selected_nodes()[0] as Node
    var pos := Vector3.ZERO
    for item in first.get_children():
        item.position = pos
        pos.x += offset.x
        if pos.x > max_width:
            pos += offset
            pos.x = 0

