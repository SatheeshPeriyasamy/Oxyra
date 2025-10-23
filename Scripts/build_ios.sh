#!/bin/bash

# Build script for Oxyra iOS framework
# This script compiles the C++ core for iOS and creates the necessary framework

set -e

# Configuration
BUILD_DIR="build_ios"
FRAMEWORK_NAME="OxyraCore"
FRAMEWORK_DIR="Sources/OxyraCore/Frameworks"

# Clean previous builds
echo "Cleaning previous builds..."
rm -rf $BUILD_DIR
rm -rf $FRAMEWORK_DIR

# Create directories
mkdir -p $BUILD_DIR
mkdir -p $FRAMEWORK_DIR

# Build for iOS device (arm64)
echo "Building for iOS device (arm64)..."
cd $BUILD_DIR

cmake .. \
    -DCMAKE_TOOLCHAIN_FILE=../CMakeLists_IOS.txt \
    -DIOS_PLATFORM=OS \
    -DARCH=arm64 \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=../$FRAMEWORK_DIR \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_OSX_ARCHITECTURES=arm64

make -j$(sysctl -n hw.ncpu)

# Build for iOS simulator (x86_64 and arm64)
echo "Building for iOS simulator..."
cd ..

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR
cd $BUILD_DIR

cmake .. \
    -DCMAKE_TOOLCHAIN_FILE=../CMakeLists_IOS.txt \
    -DIOS_PLATFORM=SIMULATOR \
    -DARCH=x86_64 \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=../$FRAMEWORK_DIR \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_OSX_ARCHITECTURES=x86_64

make -j$(sysctl -n hw.ncpu)

# Create universal framework
echo "Creating universal framework..."
cd ..

# Create framework structure
mkdir -p $FRAMEWORK_DIR/$FRAMEWORK_NAME.framework/Headers
mkdir -p $FRAMEWORK_DIR/$FRAMEWORK_NAME.framework/Modules

# Copy headers
cp Sources/OxyraCore/include/*.h $FRAMEWORK_DIR/$FRAMEWORK_NAME.framework/Headers/
cp Sources/OxyraCore/include/module.modulemap $FRAMEWORK_DIR/$FRAMEWORK_NAME.framework/Modules/

# Create Info.plist
cat > $FRAMEWORK_DIR/$FRAMEWORK_NAME.framework/Info.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundleExecutable</key>
    <string>$FRAMEWORK_NAME</string>
    <key>CFBundleIdentifier</key>
    <string>com.oxyra.$FRAMEWORK_NAME</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>$FRAMEWORK_NAME</string>
    <key>CFBundlePackageType</key>
    <string>FMWK</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>MinimumOSVersion</key>
    <string>13.0</string>
</dict>
</plist>
EOF

echo "Build completed successfully!"
echo "Framework created at: $FRAMEWORK_DIR/$FRAMEWORK_NAME.framework"
