// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "NewsDetailModule",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "NewsDetailModule", targets: ["NewsDetailModule"]),
    ],
    dependencies: [
        .package(path: "../CommonModule"),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.18.0")
    ],
    targets: [
        .target(
            name: "NewsDetailModule",
            dependencies: [
                "CommonModule",
                .product(name: "SDWebImage", package: "SDWebImage")
            ]
        )
    ]
)
