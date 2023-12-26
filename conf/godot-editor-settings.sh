mkdir -pv ~/.config/godot

cat << EOF >> ~/.config/godot/editor_settings-3.tres
[gd_resource type="EditorSettings" format=2]

[resource]
export/android/android_sdk_path = "/usr/local/lib/android/sdk"
export/windows/rcedit = "/base/bin/rcedit-x64.exe"
export/windows/wine = "`which wine`"
EOF

cat << EOF >> ~/.config/godot/editor_settings-4.tres
[gd_resource type="EditorSettings" format=3]

[resource]
filesystem/import/blender/blender3_path = "/base/blender"
filesystem/import/blender/enabled = true
export/android/android_sdk_path = "/usr/local/lib/android/sdk"
export/windows/rcedit = "/base/bin/rcedit-x64.exe"
export/windows/wine = "`which wine`"
export/macos/rcodesign = "/base/bin/rcodesign"
EOF
