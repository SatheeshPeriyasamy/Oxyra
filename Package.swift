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
                .define("IOS", to: "1"),
                .define("CMAKE_BUILD_TYPE", to: "Release"),
                .define("NDEBUG", to: "1"),
                .define("__STDC_FORMAT_MACROS", to: "1"),
                .define("_LIBCPP_ENABLE_CXX17_REMOVED_UNARY_BINARY_FUNCTION", to: "1"),
                .define("_LIBCPP_ENABLE_CXX17_REMOVED_AUTO_PTR", to: "1"),
                .define("_LIBCPP_VERSION", to: "14000"),
                .define("__APPLE__", to: "1"),
                .define("TARGET_OS_IPHONE", to: "1"),
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
