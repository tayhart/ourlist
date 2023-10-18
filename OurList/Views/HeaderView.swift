//
//  SwiftUIView.swift
//  OurList
//
//  Created by Taylor Hartman on 10/17/23.
//

import SwiftUI

struct HeaderView: View {

    let title: String
    let subtitle: String
    let angle: Double
    let backgroundColor: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(backgroundColor)
                .rotationEffect(Angle(degrees: angle))
            VStack {
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(
                        size: 50,
                        weight: .bold))
                Text(subtitle)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
            .padding(.top, 80)
        }
        .frame(width: UIScreen.main.bounds.width * 3,
               height: 350)
        .offset(y: -150)
    }
}

#Preview {
    HeaderView(title: "Title", subtitle: "subtitle", angle: 15, backgroundColor: .blue)
}
