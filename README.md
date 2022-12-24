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
![toolbar](https://user-images.githubusercontent.com/43559/209448353-f48bf87c-a238-475e-acc5-3de8646f568d.png)

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

![rename copy first](https://user-images.githubusercontent.com/43559/209448514-73e76260-0211-4d33-940a-c47622d0d0e3.png)

# Included scripts

Some of the included scripts as demonstrations of what's possible:

align_to_grid.gd
![align to grid](https://user-images.githubusercontent.com/43559/209448452-a7c2d080-86f9-455a-910c-d2c2f42b8483.png)


layout_circle.gd
![layout circle](https://user-images.githubusercontent.com/43559/209448619-32424745-768e-4165-96c3-a7a4eda8ee2b.png)


rename_selected.gd
![rename selected](https://user-images.githubusercontent.com/43559/209448442-308f1806-7617-4033-8169-c339a02ddcdc.png)


# Troubleshooting

Sometimes Godot won't recompile your code so you'll have to disable + enable
the EditorScript-Launcher plugin or restart the editor.


# License

MIT
