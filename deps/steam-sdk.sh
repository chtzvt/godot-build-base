STEAM_SDK_URL="https://cdn.ctis.me/file/ctisme-cdn/files-pub/ext/water-museum/steam-sdk/steamworks_sdk_155.zip"
STEAM_SDK_LOCATION="/base/steam-sdk"

curl -o ./steam_sdk.zip $STEAM_SDK_URL

mkdir -p $STEAM_SDK_LOCATION

unzip -qq -o ./steam_sdk.zip -d $STEAM_SDK_LOCATION
rm -f ./steam_sdk.zip

# sed -i 's+sdk_dir = ".*"+sdk_dir = "${{ env.STEAM_SDK_LOCATION }}/sdk"+g' ./addons/steam_api/settings.tres || true