// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Media",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Media",
            targets: ["Media"]),
    ],
    targets: [
        .target(
            name: "Media",
            dependencies: []),
        .testTarget(
            name: "MediaTests",
            dependencies: ["Media"]),
    ]
)
