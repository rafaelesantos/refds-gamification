// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RefdsGamification",
    defaultLocalization: "pt",
    platforms: [
        .iOS(.v18),
        .macCatalyst(.v18),
        .macOS(.v15),
        .tvOS(.v18),
        .watchOS(.v11),
        .visionOS(.v2),
        .driverKit(.v24)
    ],
    products: [
        .library(
            name: "RefdsGamification",
            targets: ["RefdsGamification"]),
    ],
    dependencies: [
        .package(url: "https://github.com/rafaelesantos/refds-shared.git", branch: "main"),
        .package(url: "https://github.com/rafaelesantos/refds-injection.git", branch: "main")
    ],
    targets: [
        .target(
            name: "RefdsGamification",
            dependencies: [
                .product(name: "RefdsShared", package: "refds-shared"),
                .product(name: "RefdsInjection", package: "refds-injection")
            ]),
    ]
)
