tool
extends Launchable


static func run_script(ed: EditorInterface, ui_root: Control):
    printt("/code/godot/addons/editor-script-bar/code/editor/rename_selected.gd")
    var sel := ed.get_selection()
    var i := 0
    for item in sel.get_selected_nodes():
        item.name = "Renamed %d".format(i)
        i += 1

