// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CedroWebSocket",
    platforms: [
        .iOS(.v14),
        .macOS(.v12),
        .macCatalyst(.v15)
    ],
    products: [
        .library(
            name: "CedroWebSocket",
            targets: ["CedroWebSocket", "CedroWebSocketDomain", "CedroWebSocketData", "CedroWebSocketPresentation"]),
    ],
    dependencies: [
        .package(url: "https://github.com/rafaelesantos/refds-core.git", branch: "main")
    ],
    targets: [
        .target(
            name: "CedroWebSocket",
            dependencies: [
                "CedroWebSocketDomain",
                "CedroWebSocketData",
                "CedroWebSocketPresentation",
                .product(name: "RefdsCore", package: "refds-core")
            ]),
        .target(
            name: "CedroWebSocketDomain",
            dependencies: [.product(name: "RefdsCore", package: "refds-core")]),
        .target(
            name: "CedroWebSocketData",
            dependencies: [
                "CedroWebSocketDomain",
                .product(name: "RefdsCore", package: "refds-core")
            ]),
        .target(
            name: "CedroWebSocketPresentation",
            dependencies: [
                "CedroWebSocketDomain",
                .product(name: "RefdsCore", package: "refds-core")
            ]),
        .executableTarget(
            name: "CedroWebSocketExample",
            dependencies: [
                "CedroWebSocket",
                "CedroWebSocketDomain",
                "CedroWebSocketData",
                "CedroWebSocketPresentation",
                .product(name: "RefdsCore", package: "refds-core")
            ]),
        .testTarget(
            name: "CedroWebSocketTests",
            dependencies: [
                "CedroWebSocket",
                "CedroWebSocketDomain",
                "CedroWebSocketData",
                "CedroWebSocketPresentation",
                .product(name: "RefdsCore", package: "refds-core")
            ]),
    ]
)
