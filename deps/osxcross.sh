SDK_URL="https://cdn.ctis.me/file/ctisme-cdn/files-pub/ext/water-museum/macos-sdk"
OSX_VERSION="13.0"
export OCDEBUG=1
export UNATTENDED="yes"

mkdir -p /base/osxcross

repeat(){
    for i in {1..90}; do echo -n "$1"; done
}

echo "Installing Deps"
apt -y -qq install clang gcc g++ zlib1g-dev libmpc-dev libmpfr-dev libgmp-dev cmake lzma-dev libxml2-dev zlib1g-dev libssl-dev
apt -y -qq install clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python3-clang 

OSXCROSS_FOLDER="/base/osxcross"

echo "Cloning osxcross"
git clone https://github.com/tpoechtrager/osxcross "$OSXCROSS_FOLDER"

echo "Fetching macOS SDK"
FILE_NAME="MacOSX$OSX_VERSION.sdk.tar.xz"

# Check sdk-url for release
curl -s -L "$SDK_URL/$OSX_VERSION/${FILE_NAME}" -o "$OSXCROSS_FOLDER/tarballs/${FILE_NAME}"

OSXCROSS_TARGET=${OSXCROSS_FOLDER}/target

echo "OSXCROSS_TARGET=${OSXCROSS_TARGET}" >> /base/conf/osxcross.env
echo "OSXCROSS_FOLDER=${OSXCROSS_FOLDER}" >> /base/conf/osxcross.env

# Build osxcross
echo "Building osxcross..."
cd "$OSXCROSS_FOLDER"
bash "$OSXCROSS_FOLDER"/build.sh

chmod +x $OSXCROSS_FOLDER/target/bin/*

echo "Finding Executables"
#echo "$OSXCROSS_FOLDER/target/bin" >> $GITHUB_PATH

for file in "$OSXCROSS_FOLDER/target/bin"/*; do
    if [ -x "$file" ]; then
        filename=$(basename "$file")
        ln -s "$file" "/usr/local/bin/$filename"
    fi
done

findTarget() {
    local file="$(find "$OSXCROSS_FOLDER/target/bin" -name "$1")"
    echo "$(basename $file)"
}

LINKER_FILE="$(findTarget "x86_64-apple-darwin*-clang")"
AR_FILE="$(findTarget "x86_64-apple-darwin*-ar")"

echo "Setting: CARGO_TARGET_X86_64_APPLE_DARWIN_RUSTFLAGS=\"-C linker=${AR_FILE} -C linker=${LINKER_FILE} -C link-arg=-undefined -C link-arg=dynamic_lookup\"" 
echo "CARGO_TARGET_X86_64_APPLE_DARWIN_LINKER=${LINKER_FILE}" >> /base/conf/osxcross.env
echo "CARGO_TARGET_X86_64_APPLE_DARWIN_RUSTFLAGS=-Car=${AR_FILE},-Clink-arg=-undefined,-Clink-arg=dynamic_lookup" >> /base/conf/osxcross.env
echo "OSXCROSS_ROOT=$OSXCROSS_FOLDER" >> /base/conf/osxcross.env

cat /base/conf/osxcross.env >> /etc/environment