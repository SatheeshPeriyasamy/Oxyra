// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Oxyra",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "Oxyra",
            targets: ["Oxyra"]),
        .library(
            name: "OxyraCore",
            targets: ["OxyraCore"]),
    ],
    dependencies: [
        // No external dependencies - Oxyra is self-contained
    ],
    targets: [
        // Main Oxyra Swift wrapper
        .target(
            name: "Oxyra",
            dependencies: ["OxyraCore"],
            path: "Sources/Oxyra",
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include"),
                .define("IOS", to: "1"),
                .define("CMAKE_BUILD_TYPE", to: "Release"),
                .define("NDEBUG", to: "1"),
            ],
            cxxSettings: [
                .headerSearchPath("include"),
                .define("IOS", to: "1"),
                .define("CMAKE_BUILD_TYPE", to: "Release"),
                .define("NDEBUG", to: "1"),
                .define("__STDC_FORMAT_MACROS", to: "1"),
            ],
            linkerSettings: [
                .linkedLibrary("c++"),
                .linkedLibrary("z"),
                .linkedLibrary("sqlite3"),
            ]
        ),
        // Core C++ bridge library
        .target(
            name: "OxyraCore",
            dependencies: [],
            path: "Sources/OxyraCore",
            sources: ["oxyra_bridge.cpp"],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include"),
                .define("IOS", to: "1"),
                .define("CMAKE_BUILD_TYPE", to: "Release"),
                .define("NDEBUG", to: "1"),
            ],
            cxxSettings: [
                .headerSearchPath("include"),
                .headerSearchPath("../../src"),
                .headerSearchPath("../../src/daemon"),
                .headerSearchPath("../../src/cryptonote_core"),
                .headerSearchPath("../../src/cryptonote_basic"),
                .headerSearchPath("../../src/crypto"),
                .headerSearchPath("../../src/common"),
                .headerSearchPath("../../src/serialization"),
                .headerSearchPath("../../src/wallet"),
                .headerSearchPath("../../src/rpc"),
                .headerSearchPath("../../src/net"),
                .headerSearchPath("../../src/p2p"),
                .headerSearchPath("../../src/cryptonote_protocol"),
                .headerSearchPath("../../src/device"),
                .headerSearchPath("../../src/ringct"),
                .headerSearchPath("../../src/multisig"),
                .headerSearchPath("../../src/mnemonics"),
                .headerSearchPath("../../src/blockchain_db"),
                .headerSearchPath("../../src/checkpoints"),
                .headerSearchPath("../../src/daemonizer"),
                .headerSearchPath("../../src/hardforks"),
                .headerSearchPath("../../src/lmdb"),
                .headerSearchPath("../../src/seraphis_crypto"),
                .headerSearchPath("../../src/simplewallet"),
                .define("IOS", to: "1"),
                .define("CMAKE_BUILD_TYPE", to: "Release"),
                .define("NDEBUG", to: "1"),
                .define("__STDC_FORMAT_MACROS", to: "1"),
            ],
            linkerSettings: [
                .linkedLibrary("c++"),
                .linkedLibrary("z"),
                .linkedLibrary("sqlite3"),
            ]
        ),
        .testTarget(
            name: "OxyraTests",
            dependencies: ["Oxyra", "OxyraCore"],
            path: "Tests",
            sources: ["OxyraTests.swift"]
        ),
    ],
    cLanguageStandard: .c11,
    cxxLanguageStandard: .cxx17
)
