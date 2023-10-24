// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "adaptive-modal",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "AdaptiveModal", targets: ["AdaptiveModal"])
    ],
    targets: [
        .target(name: "AdaptiveModal")
    ]
)
