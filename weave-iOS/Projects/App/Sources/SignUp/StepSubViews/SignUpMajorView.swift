//
//  SignUpMajorView.swift
//  weave-ios
//
//  Created by Jisu Kim on 2/5/24.
//

import SwiftUI
import DesignSystem

struct SignUpMajorView: View {
    
    @State var selectedSchool: (any WeaveDropDownFetchable)?
    @State var text = String()
    
    var body: some View {
        VStack {
            WeaveDropDownPicker(
                selectedItem: $selectedSchool,
                dataSources: MajorModel.mockUp()
            ) {
                WeaveTextField(
                    text: .constant(selectedSchool?.name ?? ""),
                    placeholder: "위브학과",
                    showClearButton: true
                )
            }
        }
    }
}

#Preview {
    SignUpMajorView()
}
