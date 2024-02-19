import ProjectDescription

let target = Target(
    name: "Services",
    platform: .iOS,
    product: .staticFramework,
    bundleId: "com.studentcenter.weaveios.services",
    deploymentTarget: .iOS(targetVersion: "17.0",
                           devices: .iphone,
                           supportsMacDesignedForIOS: false),
    sources: ["Sources/**"],
    dependencies: []
)

let project = Project(
    name: "Core",
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

