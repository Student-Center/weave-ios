//
//  WeaveButtonExample.swift
//  DesignSystem
//
//  Created by Jisu Kim on 1/20/24.
//

import SwiftUI

struct WeaveButtonExample: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 15) {
                WeaveButton(
                    title: "Large",
                    icon: Image(systemName: "heart"),
                    style: .filled,
                    size: .large,
                    isEnabled: false
                ) {
                        print("탭!")
                    }
                    .frame(width: 150)
                
                WeaveButton(
                    title: "Large",
                    style: .outline,
                    size: .large) {
                        print("탭!")
                    }
                    .frame(width: 150)
            }
            
            HStack(spacing: 15) {
                WeaveButton(
                    title: "Medium",
                    style: .filled,
                    size: .medium) {
                        print("탭!")
                    }
                    .frame(width: 150)
                
                WeaveButton(
                    title: "Medium",
                    style: .outline,
                    size: .medium) {
                        print("탭!")
                    }
                    .frame(width: 150)
            }
            
            HStack(spacing: 15) {
                WeaveButton(
                    title: "Regular",
                    style: .filled,
                    size: .regular) {
                        print("탭!")
                    }
                    .frame(width: 150)
                
                WeaveButton(
                    title: "Regular",
                    style: .outline,
                    size: .regular) {
                        print("탭!")
                    }
                    .frame(width: 150)
            }
            
            HStack(spacing: 15) {
                WeaveButton(
                    title: "small",
                    style: .filled,
                    size: .small) {
                        print("탭!")
                    }
                    .frame(width: 150)
                
                WeaveButton(
                    title: "small",
                    style: .outline,
                    size: .small) {
                        print("탭!")
                    }
                    .frame(width: 150)
            }
        }
    }
}

#Preview {
    WeaveButtonExample()
}
