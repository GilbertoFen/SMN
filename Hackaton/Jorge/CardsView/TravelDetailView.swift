import SwiftUI

struct TravelDetailView: View
{
    let card: TravelCard

    var body: some View
    {
        VStack(spacing: 20)
        {
            Image(card.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 280)
                .frame(maxWidth: .infinity)
                .clipped()
                .cornerRadius(20)

            VStack(alignment: .leading, spacing: 12)
            {
                Text(card.title)
                    .font(.largeTitle.bold())

                Text(card.subtitle)
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
        }
        .padding()
        .navigationTitle(card.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
