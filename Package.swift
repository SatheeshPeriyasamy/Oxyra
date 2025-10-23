// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Oxyra",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Oxyra",
            targets: ["Oxyra"]),
    ],
    targets: [
        .target(
            name: "Oxyra",
            dependencies: [],
            path: "Sources/Oxyra"
        )
    ]
)
