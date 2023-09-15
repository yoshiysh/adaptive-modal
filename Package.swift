// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "adaptive-modal",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "AdaptiveModal", targets: ["AdaptiveModal"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
    ],
    targets: [
        .target(name: "AdaptiveModal")
    ]
)
