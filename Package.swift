// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SQServiceStorage",
    platforms: [ .iOS(.v16),.macOS(.v13) ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SQServiceStorage",
            targets: ["SQServiceStorage"])
    ],
    dependencies: [
        .package(url: "https://github.com/supabase-community/supabase-swift.git", from: "2.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "SQServiceStorage",
            dependencies: [
                .product(name: "Supabase", package: "supabase-swift")
        ]),
        .testTarget(name: "PlaylistCahingTests", dependencies: ["SQServiceStorage"]),
        .testTarget(name: "QuerierTests", dependencies: ["SQServiceStorage"]),
    ]
)
