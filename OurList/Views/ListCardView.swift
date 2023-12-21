//
//  ListCardView.swift
//  OurList
//
//  Created by Taylor Hartman on 12/3/23.
//

import SwiftUI

struct ListCardView: View {
    @Environment(\.self) var environment
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
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .font(.title)
                        .foregroundStyle(getTextColor())
                        .padding()
                    Spacer()
                }
            }
            .frame(height: 100)
            .background(color)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.black, lineWidth: 5)
            )
            .cornerRadius(12)

        }
    }

    func getTextColor() -> Color {
        // using an RGB -> Luma Conversion formula approximation for perf
        // Y = 0.33 R + 0.5 G + 0.16 B
        let (r, g, b, _) = UIColor(color).rgbComponents
        let lumaValue = 0.33 * r + 0.5 * g + 0.16 * b
        if lumaValue > 0.5 {
            return .black
        } else {
            return .white
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
