// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "multipart-kit-issue",
    platforms: [
       .macOS(.v10_14)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/multipart-kit.git", from: "4.0.0-beta.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "multipart-kit-issue",
            dependencies: ["MultipartKit"]),
        .testTarget(
            name: "multipart-kit-issueTests",
            dependencies: ["multipart-kit-issue"]),
    ]
)
