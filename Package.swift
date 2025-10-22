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
        // Add any external dependencies here if needed
    ],
    targets: [
        .target(
            name: "Oxyra",
            dependencies: ["OxyraCore"],
            path: "Sources/Oxyra",
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include"),
                .define("IOS", to: "1"),
                .define("CMAKE_BUILD_TYPE", to: "Release"),
            ],
            linkerSettings: [
                .linkedLibrary("c++"),
                .linkedLibrary("z"),
                .linkedLibrary("sqlite3"),
            ]
        ),
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
