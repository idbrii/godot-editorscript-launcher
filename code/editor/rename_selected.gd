tool
extends LaunchableScript


static func run_script(ed: EditorInterface, ui_root: Control):
    var selection := LaunchableScript.get_selection_or_children(ed)
    var i := 0
    for item in selection:
        item.name = "Renamed %d" % i
        printt(item.name)
        i += 1
