// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    // package名
    name: "SampleToDoApp",
    // プラットフォームの指定
    platforms: [.iOS(.v17)],
    // .libraryという形式でモジュールを追加していく
    products: [
        .library(name: "AppFeature", targets: ["AppFeature"])
    ],
    // ライブラリなどの依存関係を定義する
    dependencies: [
    ],
    // targetやtest用のtargetを追加していく
    targets: [
        .target(name: "AppFeature")
    ]
)
