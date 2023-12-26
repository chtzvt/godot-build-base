curl -o blender.tar.xz https://cdn.ctis.me/file/ctisme-cdn/files-pub/ext/water-museum/blender/blender-3.6.5-linux-x64.tar.xz

tar xf blender.tar.xz && mv -v $(ls -d */ | grep blender) /base/blender

rm -f blender.tar.xz

apt -y install libsm6 libxext6 libxrender-dev libgl1-mesa-dev libglu1-mesa-dev