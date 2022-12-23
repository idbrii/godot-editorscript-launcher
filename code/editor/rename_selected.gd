tool
extends LaunchableScript


static func run_script(ed: EditorInterface, ui_root: Control):
    printt("/code/godot/addons/editor-script-bar/code/editor/rename_selected.gd")
    var sel := ed.get_selection()
    var selection := sel.get_selected_nodes()
    # Sort to ensure results match order seen in editor.
    selection.sort_custom(SortByChildIndex.new(), "cmp")
    var i := 0
    for item in selection:
        item.name = "Renamed %d" % i
        printt(item.name)
        i += 1


class SortByChildIndex extends Object:
    func cmp(a, b):
        return a.get_index() < b.get_index()
