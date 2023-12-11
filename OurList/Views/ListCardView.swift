//
//  ListCardView.swift
//  OurList
//
//  Created by Taylor Hartman on 12/3/23.
//

import SwiftUI

struct ListCardView: View {
    let title: String
    let color: Color

    init(title: String, color: Color = .random) {
        self.title = title
        self.color = color
    }

    var body: some View {
        // todo: make this a configurable style and apply it instead of
        // doing this
        if title == "+" {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.blue)
                VStack {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
            }
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(color)
                VStack {
                    Text(title)
                        .font(.title)
                }
            }
        }
    }
}

#Preview {
    ListCardView(title: "+", color: .cyan)
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
