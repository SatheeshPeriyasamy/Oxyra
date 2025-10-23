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
    ],
    dependencies: [
        // No external dependencies - Oxyra is self-contained
    ],
    targets: [
        // Main Oxyra Swift wrapper - simplified without C++ bridge for now
        .target(
            name: "Oxyra",
            dependencies: [],
            path: "Sources/Oxyra",
            cSettings: [
                .define("IOS", to: "1"),
                .define("CMAKE_BUILD_TYPE", to: "Release"),
                .define("NDEBUG", to: "1"),
            ],
            cxxSettings: [
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
            dependencies: ["Oxyra"],
            path: "Tests",
            sources: ["OxyraTests.swift"]
        ),
    ],
    cLanguageStandard: .c11,
    cxxLanguageStandard: .cxx17
)
