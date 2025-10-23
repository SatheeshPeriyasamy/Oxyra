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
        .library(
            name: "OxyraDevelopment",
            targets: ["OxyraDevelopment"]),
    ],
    dependencies: [
        // Add any external dependencies here if needed
    ],
    targets: [
        // Production target
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
                .define("PRODUCTION", to: "1"),
            ],
            cxxSettings: [
                .headerSearchPath("include"),
                .define("IOS", to: "1"),
                .define("CMAKE_BUILD_TYPE", to: "Release"),
                .define("NDEBUG", to: "1"),
                .define("PRODUCTION", to: "1"),
                .define("__STDC_FORMAT_MACROS", to: "1"),
            ],
            linkerSettings: [
                .linkedLibrary("c++"),
                .linkedLibrary("z"),
                .linkedLibrary("sqlite3"),
            ]
        ),
        // Development target
        .target(
            name: "OxyraDevelopment",
            dependencies: ["OxyraCore"],
            path: "Sources/Oxyra",
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include"),
                .define("IOS", to: "1"),
                .define("CMAKE_BUILD_TYPE", to: "Debug"),
                .define("DEBUG", to: "1"),
                .define("DEVELOPMENT", to: "1"),
            ],
            cxxSettings: [
                .headerSearchPath("include"),
                .define("IOS", to: "1"),
                .define("CMAKE_BUILD_TYPE", to: "Debug"),
                .define("DEBUG", to: "1"),
                .define("DEVELOPMENT", to: "1"),
                .define("__STDC_FORMAT_MACROS", to: "1"),
            ],
            linkerSettings: [
                .linkedLibrary("c++"),
                .linkedLibrary("z"),
                .linkedLibrary("sqlite3"),
            ]
        ),
        // Core C++ library
        .target(
            name: "OxyraCore",
            dependencies: [],
            path: "Sources/OxyraCore",
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include"),
                .headerSearchPath("src"),
                .define("IOS", to: "1"),
                .define("CMAKE_BUILD_TYPE", to: "Release"),
                .define("NDEBUG", to: "1"),
            ],
            cxxSettings: [
                .headerSearchPath("include"),
                .headerSearchPath("src"),
                .headerSearchPath("../../src"),
                .headerSearchPath("../../src/cryptonote_basic"),
                .headerSearchPath("../../src/common"),
                .headerSearchPath("../../src/crypto"),
                .headerSearchPath("../../src/serialization"),
                .headerSearchPath("../../src/wallet"),
                .headerSearchPath("../../src/rpc"),
                .headerSearchPath("../../src/net"),
                .headerSearchPath("../../src/p2p"),
                .headerSearchPath("../../src/cryptonote_core"),
                .headerSearchPath("../../src/cryptonote_protocol"),
                .headerSearchPath("../../src/daemon"),
                .headerSearchPath("../../src/device"),
                .headerSearchPath("../../src/device_trezor"),
                .headerSearchPath("../../src/ringct"),
                .headerSearchPath("../../src/multisig"),
                .headerSearchPath("../../src/mnemonics"),
                .headerSearchPath("../../src/blockchain_db"),
                .headerSearchPath("../../src/blockchain_utilities"),
                .headerSearchPath("../../src/blocks"),
                .headerSearchPath("../../src/checkpoints"),
                .headerSearchPath("../../src/daemonizer"),
                .headerSearchPath("../../src/debug_utilities"),
                .headerSearchPath("../../src/gen_multisig"),
                .headerSearchPath("../../src/gen_ssl_cert"),
                .headerSearchPath("../../src/hardforks"),
                .headerSearchPath("../../src/lmdb"),
                .headerSearchPath("../../src/seraphis_crypto"),
                .headerSearchPath("../../src/simplewallet"),
                .headerSearchPath("../../src/wallet/api"),
                .headerSearchPath("../../src/wallet/core"),
                .headerSearchPath("../../src/wallet/crypto"),
                .headerSearchPath("../../src/wallet/device"),
                .headerSearchPath("../../src/wallet/keys"),
                .headerSearchPath("../../src/wallet/rpc"),
                .headerSearchPath("../../src/wallet/tx_construction"),
                .headerSearchPath("../../src/wallet/wallet2"),
                .headerSearchPath("../../src/wallet/wallet_args"),
                .headerSearchPath("../../src/wallet/wallet_errors"),
                .headerSearchPath("../../src/wallet/wallet_rpc_server"),
                .headerSearchPath("../../src/wallet/wallet_rpc_server_commands"),
                .headerSearchPath("../../src/wallet/wallet_rpc_server_json"),
                .headerSearchPath("../../src/wallet/wallet_rpc_server_json_types"),
                .headerSearchPath("../../src/wallet/wallet_rpc_server_json_utils"),
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
            path: "Tests"
        ),
    ],
    cLanguageStandard: .c11,
    cxxLanguageStandard: .cxx17
)
