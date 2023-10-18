//
//  OLButton.swift
//  OurList
//
//  Created by Taylor Hartman on 10/17/23.
//

import SwiftUI

struct OLButton: View {
    let title: String
    let background: Color
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)

                Text(title)
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
}

#Preview {
    OLButton(title: "Test title", background: .pink) {
        // action
    }
}
