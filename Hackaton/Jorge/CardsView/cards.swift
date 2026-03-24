import SwiftUI

struct CardsView: View
{
    let imageName: String
    let title: String
    let subtitle: String
    var parallaxOffset: CGFloat = 0
    var color: Color = .clear

    private let cardWidth: CGFloat = 320
    private let cardHeight: CGFloat = 360
    private let imageWidth: CGFloat = 470

    var body: some View
    {
        ZStack(alignment: .bottomLeading)
        {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: imageWidth, height: cardHeight)
                .offset(x: parallaxOffset * 0.9)
                .frame(width: cardWidth, height: cardHeight)
                .clipped()

            LinearGradient(
                colors: [.clear, .black.opacity(0.85)],
                startPoint: .center,
                endPoint: .bottom
            )
            .frame(width: cardWidth, height: cardHeight)

            VStack(alignment: .leading, spacing: 8)
            {
                Text(title)
                    .font(.title.bold())

                Text(subtitle)
                    .font(.subheadline)
                    .opacity(0.9)

            }
            .foregroundColor(.white)
            .padding()
            .frame(width: cardWidth, height: cardHeight, alignment: .bottomLeading)
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(color.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .contentShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 10)
    }
}
