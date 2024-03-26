import ProjectDescription

let target = Target(
    name: "DesignSystem",
    platform: .iOS,
    product: .framework,
    bundleId: "com.studentcenter.weaveios.designSystem",
    deploymentTarget: .iOS(targetVersion: "17.0",
                           devices: .iphone,
                           supportsMacDesignedForIOS: false),
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "CoreKit",
                 path: .relativeToRoot("Projects/Core")),
        .external(name: "Kingfisher")
    ]
)

let project = Project(
    name: "DesignSystem",
    organizationName: nil,
    options: .options(),
    packages: [],
    settings: nil,
    targets: [target],
    schemes: [],
    fileHeaderTemplate: nil,
    additionalFiles: [],
    resourceSynthesizers: [
      .custom(name: "Assets", parser: .assets, extensions: ["xcassets"]),
      .fonts()
    ]
)

