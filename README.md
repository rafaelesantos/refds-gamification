# Product Name

[![CI](https://github.com/rafaelesantos/refds-gamification/actions/workflows/swift.yml/badge.svg)](https://github.com/rafaelesantos/refds-gamification/actions/workflows/swift.yml)

`RefdsGamification` is a versatile library designed to implement the concept of gamification in any iOS application. This framework enables you to easily integrate achievements, experience points (XP), virtual currencies, and sync them with Game Center, making it an ideal solution for enhancing user engagement in your apps.

## Key Features
- **Achievements**: Create and manage in-app achievements to reward users for specific actions.
- **Experience Points (XP)**: Implement a leveling system to track user progress and growth.
- **Virtual Currency**: Introduce in-app coins or credits that users can earn and spend.
- **Game Center Integration**: Seamlessly sync your gamification elements with Apple's Game Center for a unified gaming experience.

## Installation

Add this project to your `Package.swift` file.

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .package(url: "https://github.com/rafaelesantos/refds-gamification.git", branch: "main")
    ],
    targets: [
        .target(
            name: "YourProject",
            dependencies: [
                .product(
                    name: "RefdsGamification",
                    package: "refds-gamification"),
            ]),
    ]
)
```
