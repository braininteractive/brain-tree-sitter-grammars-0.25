// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "TreeSitterJSP",
    products: [
        .library(name: "TreeSitterJSP", targets: ["TreeSitterJSP"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ChimeHQ/SwiftTreeSitter", from: "0.8.0"),
    ],
    targets: [
        .target(
            name: "TreeSitterJSP",
            dependencies: [],
            path: ".",
            sources: [
                "src/parser.c",
                "src/scanner.c",
            ],
            resources: [
                .copy("queries")
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .testTarget(
            name: "TreeSitterJSPTests",
            dependencies: [
                "SwiftTreeSitter",
                "TreeSitterJSP",
            ],
            path: "bindings/swift/TreeSitterJSPTests"
        ),
    ],
    cLanguageStandard: .c11
)
