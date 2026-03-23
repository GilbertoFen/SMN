//
//  CardComponent.swift
//  SMN
//
//  Created by Gil Avalos on 23/03/26.
//

import SwiftUI

struct CardComponent: View {
    @State var flipped = false

    let card: CardInfo
    var body: some View {
        let flipDegrees = flipped ? 180.0 : 0

        return VStack(
            alignment: .leading, spacing: 12) {
                Spacer()

        
            Spacer()
                Text(card.description)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(.white)
                Text(card.title)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
                Image(systemName: card.image)
                    .font(.title2)
                    .foregroundStyle(card.color)
            
            
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 130, alignment: .leading)
        .background(.ultraThinMaterial.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(.white.opacity(0.2), lineWidth: 1)
        }
    }
}

struct SimpleFlipper : View {
      @State var flipped = false

      var body: some View {

            let flipDegrees = flipped ? 180.0 : 0

            return VStack{
                  Spacer()

                  ZStack() {
                        Text("Front").placedOnCard(Color.yellow).flipRotate(flipDegrees).opacity(flipped ? 0.0 : 1.0)
                        Text("Back").placedOnCard(Color.blue).flipRotate(-180 + flipDegrees).opacity(flipped ? 1.0 : 0.0)
                  }
                  .animation(.easeInOut(duration: 0.4))
                  .onTapGesture { self.flipped.toggle() }
                  Spacer()
            }
      }
}

extension View {

      func flipRotate(_ degrees : Double) -> some View {
            return rotation3DEffect(Angle(degrees: degrees), axis: (x: 0.0, y: 1.0, z: 0.0))
      }

      func placedOnCard(_ color: Color) -> some View {
            return padding(5).frame(width: 100, height: 100, alignment: .center).background(color)
      }
}

#Preview {
    var newCard = CardInfo(
        title: "Cuando estas triste",
        description:"Depresion",
        image: "moon",
        color: Color.blue
    )
    CardComponent(card: newCard).background(.black)
}
