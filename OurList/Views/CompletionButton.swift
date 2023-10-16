//
//  CompletionButton.swift
//  OurList
//
//  Created by Taylor Hartman on 10/15/23.
//

import SwiftUI

struct CompletionButton: View {
    @Binding var isSet: Bool

    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label("Mark completed", systemImage: isSet ? "checkmark.circle.fill" : "circle")
                .labelStyle(.iconOnly)
                .foregroundStyle(isSet ? .green : .gray)
        }
    }
}

#Preview {
    CompletionButton(isSet: .constant(false))
}
