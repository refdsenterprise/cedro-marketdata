// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CedroMarketData",
    platforms: [
        .iOS(.v14),
        .macOS(.v12),
        .macCatalyst(.v15),
        .tvOS(.v14)
    ],
    products: [
        .library(
            name: "CedroMarketData",
            targets: ["CedroMarketData"]),
    ],
    dependencies: [
        .package(url: "https://github.com/refdsenterprise/refds-core.git", branch: "main"),
        .package(url: "https://github.com/refdsenterprise/cedro-authentication.git", branch: "main")
    ],
    targets: [
        .target(
            name: "CedroMarketData",
            dependencies: [
                "CedroMarketDataDomain",
                "CedroMarketDataData",
                "CedroMarketDataInfra",
                "CedroMarketDataPresentation",
                .product(name: "CedroAuthentication", package: "cedro-authentication")
            ]),
        .target(
            name: "CedroMarketDataDomain",
            dependencies: [.product(name: "RefdsCore", package: "refds-core")]),
        .target(
            name: "CedroMarketDataData",
            dependencies: [
                "CedroMarketDataDomain",
                .product(name: "RefdsCore", package: "refds-core")
            ]),
        .target(
            name: "CedroMarketDataInfra",
            dependencies: [.product(name: "RefdsCore", package: "refds-core")]),
        .target(
            name: "CedroMarketDataPresentation",
            dependencies: [
                "CedroMarketDataDomain",
                .product(name: "RefdsCore", package: "refds-core")
            ]),
        .executableTarget(
            name: "Example",
            dependencies: ["CedroMarketData"])
    ]
)
