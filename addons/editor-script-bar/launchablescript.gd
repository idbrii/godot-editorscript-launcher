tool
extends EditorScript
class_name LaunchableScript


func _run():
    run_script(get_editor_interface(), null)


static func create_ui(run_btn: Button) -> Control:
    return run_btn


static func run_script(ed: EditorInterface, ui_root: Control):
    pass

