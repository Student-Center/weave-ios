//
//  Dependencies.swift
//  ResourceSynthesizers
//
//  Created by Jisu Kim on 2/5/24.
//

import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: .init([
        .remote(
            url: "https://github.com/onevcat/Kingfisher.git",
            requirement: .upToNextMajor(from: "7.0.0")
        )
    ]
    )
)
