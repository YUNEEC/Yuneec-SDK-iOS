#!/bin/bash

set -e # fail on errors

dronecore_filename=DroneCore-iOS-v0.11.2-Release.zip
unzip_dir=Yuneec_SDK_iOS/libs/Yuneec-SDK

downloaded=false
if [ ! -f $dronecore_filename ]; then
    echo "Downloading DroneCore..."
    curl --progress-bar -O https://s3.eu-central-1.amazonaws.com/7a385c3b-88a9-2913-f590-6eecf3be1731/yuneec-sdk/ios/$dronecore_filename;
    downloaded=true
fi

if [ ! -d Yuneec_SDK_iOS/libs/ -o downloaded=true ]; then
    echo "Unzipping..."
    mkdir -p $unzip_dir
    unzip -o $dronecore_filename -d $unzip_dir
fi
