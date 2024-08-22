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
    targets: [
        .target(
            name: "RefdsGamification"),
        .testTarget(
            name: "RefdsGamificationTests",
            dependencies: ["RefdsGamification"]),
    ]
)
