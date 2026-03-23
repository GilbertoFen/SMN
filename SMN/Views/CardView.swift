//
//  CardView.swift
//  SMN
//
//  Created by Gil Avalos on 23/03/26.
//

import SwiftUI

struct CardView: View {
    
    var body: some View {
        var cards = [
            CardInfo(
                title: "Cuando estas triste",
                description:"Depresion",
                image: "moon",
                color: Color.blue),
            CardInfo(
                title: "Cuando estas triste",
                description:"Depresion",
                image: "moon",
                color: Color.blue),
            CardInfo(
                title: "Cuando estas triste",
                description:"Depresion",
                image: "moon",
                color: Color.blue)
        ]
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.fixed(100)),
                    GridItem(.flexible(minimum: 50, maximum: .infinity)),
                    GridItem(.flexible(minimum: 50, maximum: .infinity))
                ],
                alignment: .leading,
                spacing: 10
            ) {
                ForEach(0..<3, id: \.self) { column in
                    CardComponent(card: cards[column])
                }
            }.padding()
        }
    }
}

#Preview {
    CardView()
}
