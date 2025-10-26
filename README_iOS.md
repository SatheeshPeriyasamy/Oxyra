# Oxyra iOS Integration

This document describes how to use Oxyra as a Swift Package Manager (SPM) dependency in iOS projects.

## Requirements

- iOS 13.0+
- Xcode 12.0+
- Swift 5.7+

## Installation

### Swift Package Manager

Add Oxyra to your iOS project using Swift Package Manager:

1. In Xcode, go to File → Add Package Dependencies
2. Enter the repository URL: `https://github.com/SatheeshPeriyasamy/Oxyra.git`
3. Select the `add-ios-spm-support` branch
4. Add the `Oxyra` product to your target

### Manual Integration

If you prefer manual integration:

1. Clone the repository
2. Run the build script: `./Scripts/build_ios.sh`
3. Add the generated framework to your project

## Usage

### Basic Setup

```swift
import Oxyra

// Create configuration
let config = OxyraConfig(
    dataDir: "/path/to/data",
    logLevel: 0,
    testnet: false
)

// Initialize Oxyra
let oxyra = Oxyra(config: config)
```

### Starting the Daemon

```swift
// Configure daemon options
let daemonOptions = OxyraDaemonOptions(
    rpcBindIP: "127.0.0.1",
    rpcBindPort: 18081,
    p2pBindIP: "0.0.0.0",
    p2pBindPort: 18080,
    restrictedRPC: true
)

// Start daemon
let success = oxyra.startDaemon(options: daemonOptions)
if success {
    print("Daemon started successfully")
}
```

### Checking Status

```swift
// Check if daemon is running
if oxyra.isDaemonRunning() {
    let status = oxyra.getDaemonStatus()
    print("Height: \(status.height)")
    print("Synchronized: \(status.isSynchronized)")
}
```

## Building from Source

To build Oxyra for iOS from source:

```bash
# Clone the repository
git clone https://github.com/SatheeshPeriyasamy/Oxyra.git
cd Oxyra

# Checkout the iOS support branch
git checkout add-ios-spm-support

# Build for iOS
./Scripts/build_ios.sh
```

## Architecture Support

- iOS Device: arm64
- iOS Simulator: x86_64, arm64

## Troubleshooting

### Common Issues

1. **Build Errors**: Ensure you have the latest Xcode and iOS SDK
2. **Linking Issues**: Make sure all required system frameworks are linked
3. **Runtime Errors**: Check that the data directory is writable

### Dependencies

Oxyra requires the following system frameworks:
- libc++
- libz
- libsqlite3

These are automatically linked when using Swift Package Manager.

## License

See the main LICENSE file for licensing information.


