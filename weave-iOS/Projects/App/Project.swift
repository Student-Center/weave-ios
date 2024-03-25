import ProjectDescription

let target = Target(
    name: "weave-ios",
    platform: .iOS,
    product: .app,
    bundleId: "com.studentcenter.weaveios",
    deploymentTarget: .iOS(targetVersion: "17.0",
                           devices: .iphone,
                           supportsMacDesignedForIOS: false),
    infoPlist: .file(path: "Support/weave-ios-Info.plist"),
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    entitlements: .file(path: .relativeToCurrentFile("weave-ios.entitlements")),
    dependencies: [
        .project(target: "Services",
                 path: .relativeToRoot("Projects/Core")),
        .project(target: "DesignSystem",
                 path: .relativeToRoot("Projects/DesignSystem")),
        .package(product: "ComposableArchitecture", type: .macro),
        .package(product: "KakaoSDKCommon", type: .macro),
        .package(product: "KakaoSDKAuth", type: .macro),
        .package(product: "KakaoSDKUser", type: .macro),
        .package(product: "KakaoSDKShare", type: .macro),
        .package(product: "KakaoSDKTemplate", type: .macro),
    ]
)

let project = Project(
    name: "Weave-ios",
    organizationName: nil,
    options: .options(),
    packages: [
        .remote(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            requirement: .exact("1.7.2")),
        .remote(url: "https://github.com/kakao/kakao-ios-sdk", requirement: .branch("master"))
    ],
    settings: nil,
    targets: [target],
    schemes: [],
    fileHeaderTemplate: nil,
    additionalFiles: [],
    resourceSynthesizers: []
)
