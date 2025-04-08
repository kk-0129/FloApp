// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FloApp",
    platforms: [.macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FloApp",
            targets: ["FloApp"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url:"https://github.com/kk-0129/Flo2D.git", from: "1.0.0"),
        //.package(path: "../Flo2D")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FloApp",
            dependencies: [
                .product(name: "Flo2D", package:"Flo2D")
            ]),
    ]
)
