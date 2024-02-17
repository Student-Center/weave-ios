import ProjectDescription

let target = Target(
    name: "weave-ios",
    platform: .iOS,
    product: .app,
    bundleId: "com.studentcenter.weaveios",
    infoPlist: .file(path: "Support/weave-ios-Info.plist"),
    sources: ["Sources/**"],
    dependencies: [
        .project(target: "Services",
                 path: .relativeToRoot("Projects/Core")),
        .project(target: "DesignSystem",
                 path: .relativeToRoot("Projects/DesignSystem")),
        .package(product: "ComposableArchitecture", type: .macro),
        .external(name: "Kingfisher"),
    ]
)

let project = Project(
    name: "Weave-ios",
    organizationName: nil,
    options: .options(),
    packages: [
        .remote(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            requirement: .exact("1.7.2"))
    ],
    settings: nil,
    targets: [target],
    schemes: [],
    fileHeaderTemplate: nil,
    additionalFiles: [],
    resourceSynthesizers: []
)
