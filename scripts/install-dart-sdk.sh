#!/usr/bin/env bash

set -e -o pipefail

[[ -z "$NGIO_ENV_DEFS" ]] && . ./scripts/env-set.sh

if  [[ -z "$(type -t dart)" ]]; then
    travis_fold start install.dart
    echo INSTALLING Dart SDK ...

    # URL for sdk:
    # https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-linux-x64-release.zip

    : ${DART_SDK_CHANNEL:=$(node -p 'require("./src/_data/pkg-vers.json").SDK.channel')} # dev or stable
    : ${DART_SDK_VERS:=$(node -p 'require("./src/_data/pkg-vers.json").SDK.vers')} # dev or stable

    DART_ARCHIVE=https://storage.googleapis.com/dart-archive/channels
    VERS=$DART_SDK_CHANNEL/release/$DART_SDK_VERS

    mkUrl() {
        local dir=$1
        local pkg=$2
        local arch=$3
        local zip=$pkg-$_OS_NAME-$arch-release.zip
        echo "$DART_ARCHIVE/$VERS/$dir/$zip";
    }

    getAndInstall() {
        local dir=$1
        local pkg=${2:-$dir};
        local arch=${3:-x64}
        local URL=$(mkUrl $dir $pkg $arch)
        local exitStatus=0;
        local zip=$(basename $URL)

        echo "Getting $pkg from:"
        echo "  $URL"

        [[ ! -d "$TMP" ]] && mkdir "$TMP"
        [[ ! -d "$PKG" ]] && mkdir "$PKG"

        curl $URL > "$TMP/$zip" # 2> /dev/null

        if [[ "1000" -lt "$(wc -c $TMP/$zip | awk '{print $1}')" ]]; then
            unzip "$TMP/$zip" -d "$PKG" > /dev/null
            rm -f "$TMP/$zip"
            # PATH is set in ./scripts/env-set.sh
        else
            echo FAILED to download Dart $pkg. Check URL.
            exitStatus=1;
        fi
    }

    if getAndInstall sdk dartsdk; then
        echo
        dart --version
    fi
    ls -l $PKG
    travis_fold end install.dart
else
    echo Dart SDK appears to be installed: `type dart`
    # PATH is set in ./scripts/env-set.sh
    dart --version
fi
