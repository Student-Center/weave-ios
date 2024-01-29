import ProjectDescription

let target = Target(
    name: "weave-ios",
    platform: .iOS,
    product: .app,
    bundleId: "com.studentcenter.weave-ios",
    infoPlist: .file(path: "Support/weave-ios-Info.plist"),
    sources: ["Sources/**"],
    dependencies: [
        .project(target: "DesignSystem",
                 path: .relativeToRoot("Projects/DesignSystem")),
    ]
)

let project = Project(
    name: "Weave-ios",
    organizationName: nil,
    options: .options(),
    packages: [],
    settings: nil,
    targets: [target],
    schemes: [],
    fileHeaderTemplate: nil,
    additionalFiles: [],
    resourceSynthesizers: []
)
