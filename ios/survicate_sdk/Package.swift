// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "survicate_sdk",
    platforms: [
        .iOS("14.0")
    ],
    products: [
        .library(name: "survicate-sdk", targets: ["survicate_sdk"])
    ],
    dependencies: [
        .package(url: "https://github.com/Survicate/survicate-ios-sdk.git", exact: "7.0.0")
    ],
    targets: [
        .target(
            name: "survicate_sdk",
            dependencies: [
                .product(name: "Survicate", package: "survicate-ios-sdk")
            ],
            resources: []
        )
    ]
)
