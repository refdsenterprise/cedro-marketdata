// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CedroStreamingWebSocket",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "CedroStreamingWebSocket",
            targets: ["CedroStreamingWebSocket"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CedroStreamingWebSocket",
            dependencies: []),
        .testTarget(
            name: "CedroStreamingWebSocketTests",
            dependencies: ["CedroStreamingWebSocket"]),
    ]
)
