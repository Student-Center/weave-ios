import ProjectDescription

let target = Target(
    name: "DesignSystem",
    platform: .iOS,
    product: .framework,
    bundleId: "com.studentcenter.weaveios.designSystem",
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: []
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

