tool
extends EditorScript


func _run():
    run_script(get_editor_interface())

static func run_script(ed: EditorInterface):
    printt("/code/godot/addons/editor-script-bar/code/editor/rename_selected.gd")
    var sel := ed.get_selection()
    var i := 0
    for item in sel.get_selected_nodes():
        item.name = "Renamed %d".format(i)
        i += 1

