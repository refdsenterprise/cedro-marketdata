// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CedroWebSocket",
    platforms: [
        .iOS(.v14),
        .macOS(.v12),
        .macCatalyst(.v15),
        .tvOS(.v14)
    ],
    products: [
        .library(
            name: "CedroWebSocket",
            targets: ["CedroWebSocket"]),
    ],
    dependencies: [
        .package(url: "https://github.com/rafaelesantos/refds-core.git", branch: "main"),
        .package(url: "https://github.com/rafaelesantos/cedro-authentication.git", branch: "main")
    ],
    targets: [
        .target(
            name: "CedroWebSocket",
            dependencies: [
                "CedroWebSocketDomain",
                "CedroWebSocketData",
                "CedroWebSocketInfra",
                "CedroWebSocketPresentation",
                .product(name: "CedroAuthentication", package: "cedro-authentication")
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
            name: "CedroWebSocketInfra",
            dependencies: [.product(name: "RefdsCore", package: "refds-core")]),
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
                .product(name: "RefdsCore", package: "refds-core"),
                .product(name: "CedroAuthentication", package: "cedro-authentication")
            ])
    ]
)
