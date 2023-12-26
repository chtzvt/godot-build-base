GODOT_VERSION="4.2.1"
RELEASE_NAME="stable"
GODOT_TEST_ARGS=""
GODOT_PLATFORM="linux.x86_64"

wget https://cdn.ctis.me/file/ctisme-cdn/files-pub/ext/water-museum/godot/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM}.zip
wget https://cdn.ctis.me/file/ctisme-cdn/files-pub/ext/water-museum/godot/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_export_templates.tpz

mkdir ~/.cache

mkdir -p ~/.config/godot

mkdir -p ~/.local/share/godot/templates/${GODOT_VERSION}.${RELEASE_NAME}

ln -s ~/.local/share/godot/templates ~/.local/share/godot/export_templates

unzip Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM}.zip

mv Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM} /usr/local/bin/godot

unzip Godot_v${GODOT_VERSION}-${RELEASE_NAME}_export_templates.tpz

mv templates/* ~/.local/share/godot/templates/${GODOT_VERSION}.${RELEASE_NAME}

rm -f Godot_v${GODOT_VERSION}-${RELEASE_NAME}_export_templates.tpz Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM}.zip

bash conf/godot-editor-settings.sh