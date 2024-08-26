// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RefdsGamification",
    defaultLocalization: "pt",
    platforms: [
        .iOS(.v17),
        .macCatalyst(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1),
        .driverKit(.v23)
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
        .testTarget(
            name: "RefdsGamificationTests",
            dependencies: ["RefdsGamification"]),
    ]
)
