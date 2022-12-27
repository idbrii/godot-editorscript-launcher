# EditorScript Launcher

Make it easy to run editor script code to make it simple to write scripts to
speed up your Godot development.

# Setup

Install and enable the addon [as
usual](https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html).

Put your editor scripts in res://code/editor/ and make them extend
`LaunchableScript`. See code/editor/layout_circle.gd and
code/editor/rename_selected.gd for examples.

You'll get a new "Script Launcher" button on the bottom toolbar that incldues
buttons for all of your scripts:
![toolbar](https://user-images.githubusercontent.com/43559/209706015-4afdf60d-db7a-48f6-8fc3-640667f50fbf.png)

# Example New Script

Add res://code/editor/rename_copy_first.gd:

```
tool
extends LaunchableScript

static func run_script(ed: EditorInterface, ui_root: Control):
    var selection := LaunchableScript.get_selection_or_children(ed)
    var name_of_first = selection[0].name.rstrip(" 0123456789")
    for item in selection:
        item.name = name_of_first
```

Hit Refresh, and now you'll have a new button!

![rename copy first](https://user-images.githubusercontent.com/43559/209706626-570118e3-0da8-4953-ab35-c7ad7e019748.png)

# Included scripts

Some of the included scripts as demonstrations of what's possible:

align_to_grid.gd
![align to grid](https://user-images.githubusercontent.com/43559/209706497-be29dbd5-8a64-4ed2-91fc-0fbd65e38492.png)


layout_circle.gd
![layout circle](https://user-images.githubusercontent.com/43559/209706506-1e469175-35c9-4c42-b1b4-ee4f937042ac.png)


rename_selected.gd
![rename selected](https://user-images.githubusercontent.com/43559/209706522-fcd0bb15-28e3-4455-b70e-3be13b6ddfa6.png)


# Troubleshooting

Sometimes Godot won't recompile your code so you'll have to disable + enable
the EditorScript-Launcher plugin or restart the editor.


# License

MIT
