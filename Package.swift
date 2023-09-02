// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "adaptive-panel",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "AdaptivePanel", targets: ["AdaptivePanel"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
    ],
    targets: [
        .target(name: "AdaptivePanel")
    ]
)
